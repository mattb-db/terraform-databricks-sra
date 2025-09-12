output "databricks_credential_id" {
  value = module.databricks_mws_account_cloud_resources.databricks_credential_id
}

output "databricks_storage_configuration_id" {
  value = module.databricks_mws_account_cloud_resources.databricks_storage_configuration_id
}

output "databricks_network_id" {
  value = module.databricks_mws_account_cloud_resources.databricks_network_id
}

output "databricks_private_access_settings_id" {
  value = module.databricks_mws_account_cloud_resources.databricks_private_access_settings_id
}

output "databricks_managed_services_customer_managed_key_id" {
  value = module.databricks_mws_account_cloud_resources.databricks_managed_services_customer_managed_key_id
}

output "databricks_storage_customer_managed_key_id" {
  value = module.databricks_mws_account_cloud_resources.databricks_storage_customer_managed_key_id
}

output "network_policy_id" {
  value = module.network_policy.network_policy_id
}

output "network_connectivity_configuration_id" {
  value = module.network_connectivity_configuration.ncc_id
}

output "metastore_id" {
  value = module.unity_catalog_metastore_creation.metastore_id
}