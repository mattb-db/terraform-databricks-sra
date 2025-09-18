# Workspace Configuration with Deployment Name
resource "databricks_mws_workspaces" "workspace" {
  account_id                               = var.databricks_account_id
  aws_region                               = var.region
  workspace_name                           = var.resource_prefix
  deployment_name                          = var.deployment_name
  credentials_id                           = var.credentials_id 
  storage_configuration_id                 = var.storage_configuration_id
  network_id                               = var.network_id
  private_access_settings_id               = var.private_access_settings_id
  managed_services_customer_managed_key_id = var.managed_services_customer_managed_key_id
  storage_customer_managed_key_id          = var.storage_customer_managed_key_id
  pricing_tier                             = "ENTERPRISE"

#  depends_on = [databricks_mws_networks.this]
}

# Attach the Network Policy
resource "databricks_workspace_network_option" "workspace_assignment" {
  network_policy_id = var.network_policy_id
  workspace_id      = databricks_mws_workspaces.workspace.workspace_id
}

# Attach the Network Connectivity Configuration Object
resource "databricks_mws_ncc_binding" "ncc_binding" {
  network_connectivity_config_id = var.network_connectivity_configuration_id
  workspace_id                   = databricks_mws_workspaces.workspace.workspace_id
}