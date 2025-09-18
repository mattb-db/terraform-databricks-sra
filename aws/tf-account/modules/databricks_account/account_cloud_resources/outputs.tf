# output "workspace_url" {
#   description = "Workspace URL."
#   value       = databricks_mws_workspaces.workspace.workspace_url
# }

# output "workspace_id" {
#   description = "Workspace ID."
#   value       = databricks_mws_workspaces.workspace.workspace_id
# }

output "databricks_credential_id" {
  value = databricks_mws_credentials.this.credentials_id
}

output "databricks_storage_configuration_id" {
  value = databricks_mws_storage_configurations.this.storage_configuration_id
}

output "databricks_network_id" {
  value = databricks_mws_networks.this.network_id
}

output "databricks_private_access_settings_id" {
  value = databricks_mws_private_access_settings.pas.private_access_settings_id
}

output "databricks_managed_services_customer_managed_key_id" {
  value = databricks_mws_customer_managed_keys.managed_services.customer_managed_key_id
}

output "databricks_storage_customer_managed_key_id" {
  value = databricks_mws_customer_managed_keys.workspace_storage.customer_managed_key_id
}