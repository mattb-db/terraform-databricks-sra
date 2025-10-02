variable "workspace_url" {
  description = "Databricks workspace URL"
  type        = string
}

variable "databricks_account_id" {
  description = "Databricks account ID"
  type        = string
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
}

variable "resource_prefix" {
  description = "Prefix used for naming and tagging resources (e.g., S3 buckets, IAM roles)"
  type        = string
}

variable "admin_user" {
  description = "Admin user email for workspace and catalog management"
  type        = string
}

variable "region" {
  description = "AWS region for deployment"
  type        = string
}

variable "workspace_id" {
  description = "Workspace id"
  type        = string
}

variable "catalog_name" {
  description = "Catalog name"
  type        = string
}