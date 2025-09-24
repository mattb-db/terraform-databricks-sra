


# User Workspace Assignment (Admin)
module "user_assignment" {
  source = "./modules/databricks_account/user_assignment"
  providers = {
    databricks = databricks.mws
  }

  workspace_id     = module.databricks_mws_workspace.workspace_id
  workspace_access = var.admin_user

#  depends_on = [module.unity_catalog_metastore_assignment, module.databricks_mws_workspace]
}

# Create Cluster
module "cluster_configuration" {
  source = "./modules/databricks_workspace/classic_cluster"
  providers = {
    databricks = databricks.created_workspace
  }

  enable_compliance_security_profile = var.enable_compliance_security_profile
  resource_prefix                    = var.resource_prefix
  region                             = var.region

  depends_on = [module.databricks_mws_workspace]
}
