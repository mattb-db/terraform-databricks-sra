terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "1.84.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.76.0"
    }
  }
  required_version = "~>1.3"
}

# Authenticate using environment variables: https://docs.aws.amazon.com/cli/v1/userguide/cli-configure-envvars.html
# export AWS_ACCESS_KEY_ID=KEY_ID
# export AWS_SECRET_ACCESS_KEY=SECRET_KEY
# export AWS_SESSION_TOKEN=SESSION_TOKEN

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Resource = var.resource_prefix
    }
  }
}

# Authenticate using environment variables: https://registry.terraform.io/providers/databricks/databricks/latest/docs#argument-reference
# export DATABRICKS_CLIENT_ID=CLIENT_ID
# export DATABRICKS_CLIENT_SECRET=CLIENT_SECRET

provider "databricks" {
  alias      = "current_workspace"
  host       = var.workspace_url
#  account_id = var.databricks_account_id
}