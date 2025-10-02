
# Creates a Workspace Isolated Catalog
module "unity_catalog_catalog_creation" {
  source = "./modules/databricks_workspace/unity_catalog_catalog_creation"
  providers = {
    databricks = databricks.current_workspace
  }

  aws_account_id               = var.aws_account_id
  aws_iam_partition            = "aws"
  aws_assume_partition         = "aws"
  unity_catalog_iam_arn        = "arn:aws:iam::414351767826:role/unity-catalog-prod-UCMasterRole-14S5ZJVKOTYTL"
  resource_prefix              = var.resource_prefix
  uc_catalog_name              = var.catalog_name
  cmk_admin_arn                = "arn:aws:iam::${var.aws_account_id}:root"
  workspace_id                 = var.workspace_id
  user_workspace_catalog_admin = var.admin_user
  bucket_name                  = var.bucket_name

}

