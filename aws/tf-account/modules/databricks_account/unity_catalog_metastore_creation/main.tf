# Terraform Documentation: https://registry.terraform.io/providers/databricks/databricks/latest/docs/guides/unity-catalog

# Optional data source - only run if the metastore exists
data "databricks_metastore" "this" {
  count  = var.metastore_exists ? 1 : 0
  #region = var.region
  #The below was added and the above commented out to get around the issue of multiple metastores per region in Databricks account
  name   = "${var.region}-metastore"
}

resource "databricks_metastore" "this" {
  count         = var.metastore_exists ? 0 : 1
  name          = "${var.region}-unity-catalog"
  region        = var.region
  force_destroy = true
}
