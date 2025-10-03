terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.76.0"
    }
  }
  required_version = "~>1.3"
}

# Authenticate using environment variables: https://registry.terraform.io/providers/databricks/databricks/latest/docs#argument-reference
# export DATABRICKS_CLIENT_ID=CLIENT_ID
# export DATABRICKS_CLIENT_SECRET=CLIENT_SECRET

provider "databricks" {
  host       = var.workspace_url
}
