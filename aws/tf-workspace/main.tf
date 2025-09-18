# # Create Databricks Workspace
module "databricks_mws_workspace" {
  source = "./modules/databricks_account/workspace"

  providers = {
    databricks = databricks.mws
  }

  # Basic Configuration
  databricks_account_id   = var.databricks_account_id
  resource_prefix       = var.resource_prefix
  region                = var.region
  deployment_name       = var.deployment_name

  # Cloud Resources
  storage_configuration_id                  = var.storage_configuration_id
  network_id                                = var.network_id
  private_access_settings_id                = var.private_access_settings_id
  managed_services_customer_managed_key_id  = var.managed_services_customer_managed_key_id
  storage_customer_managed_key_id           = var.storage_customer_managed_key_id
  network_policy_id                         = var.network_policy_id
  network_connectivity_configuration_id     = var.network_connectivity_configuration_id
  credentials_id                            = var.credentials_id

}

# Unity Catalog Assignment
module "unity_catalog_metastore_assignment" {
  source = "./modules/databricks_account/unity_catalog_metastore_assignment"
  providers = {
    databricks = databricks.mws
  }

  metastore_id = var.metastore_id
  workspace_id = module.databricks_mws_workspace.workspace_id

  #depends_on = [module.unity_catalog_metastore_creation, module.databricks_mws_workspace]
  depends_on = [module.databricks_mws_workspace]
}

# User Workspace Assignment (Admin)
module "user_assignment" {
  source = "./modules/databricks_account/user_assignment"
  providers = {
    databricks = databricks.mws
  }

  workspace_id     = module.databricks_mws_workspace.workspace_id
  workspace_access = var.admin_user

  depends_on = [module.unity_catalog_metastore_assignment, module.databricks_mws_workspace]
}

# =============================================================================
# Databricks Workspace Modules
# =============================================================================

# Creates a Workspace Isolated Catalog
module "unity_catalog_catalog_creation" {
  source = "./modules/databricks_workspace/unity_catalog_catalog_creation"
  providers = {
    databricks = databricks.created_workspace
  }

  aws_account_id               = var.aws_account_id
  aws_iam_partition            = local.computed_aws_partition
  aws_assume_partition         = local.assume_role_partition
  unity_catalog_iam_arn        = local.unity_catalog_iam_arn
  resource_prefix              = var.resource_prefix
  uc_catalog_name              = "${var.resource_prefix}-catalog-${module.databricks_mws_workspace.workspace_id}"
  cmk_admin_arn                = var.cmk_admin_arn == null ? "arn:${local.computed_aws_partition}:iam::${var.aws_account_id}:root" : var.cmk_admin_arn
  workspace_id                 = module.databricks_mws_workspace.workspace_id
  user_workspace_catalog_admin = var.admin_user

  #depends_on = [module.unity_catalog_metastore_assignment]
  depends_on = [module.databricks_mws_workspace]
}

# System Table Schemas Enablement
module "system_table" {
  count  = var.region == "us-gov-west-1" ? 0 : 1
  source = "./modules/databricks_workspace/system_schema"
  providers = {
    databricks = databricks.created_workspace
  }
  depends_on = [module.unity_catalog_metastore_assignment]
}

# Restrictive Root Buckt Policy
module "restrictive_root_bucket" {
  source = "./modules/databricks_workspace/restrictive_root_bucket"
  providers = {
    aws = aws
  }

  databricks_account_id = var.databricks_account_id
  aws_partition         = local.computed_aws_partition
  databricks_gov_shard  = var.databricks_gov_shard
  workspace_id          = module.databricks_mws_workspace.workspace_id
  region_name           = var.databricks_gov_shard == "dod" ? var.region_name_config[var.region].secondary_name : var.region_name_config[var.region].primary_name
  root_s3_bucket        = "${var.resource_prefix}-workspace-root-storage"
}

# Disable legacy settings like Hive Metastore, Disables Databricks Runtime prior to 13.3 LTS, DBFS, DBFS Mounts,etc.
module "disable_legacy_settings" {
  source = "./modules/databricks_workspace/disable_legacy_settings"
  providers = {
    databricks = databricks.created_workspace
  }
}

# Enable Compliance Security Profile (CSP) on the Databricks Workspace.
module "compliance_security_profile" {
  count  = var.enable_compliance_security_profile ? 1 : 0
  source = "./modules/databricks_workspace/compliance_security_profile"

  providers = {
    databricks = databricks.created_workspace
  }

  compliance_standards = var.compliance_standards
}

module "security_analysis_tool" {
  count  = var.enable_security_analysis_tool && var.region != "us-gov-west-1" ? 1 : 0
  source = "./modules/security_analysis_tool"

  providers = {
    databricks = databricks.created_workspace
  }

  # Authentication Variables
  databricks_account_id = var.databricks_account_id
  client_id             = null # Provide Workspace Admin ID
  client_secret         = null # Provide Workspace Admin Secret

  use_sp_auth = true

  # Databricks Variables
  analysis_schema_name = replace("${var.resource_prefix}-catalog-${module.databricks_mws_workspace.workspace_id}.SAT", "-", "_")
  workspace_id         = module.databricks_mws_workspace.workspace_id

  # Configuration Variables
  proxies           = {}
  run_on_serverless = true

  depends_on = [module.unity_catalog_catalog_creation]
}