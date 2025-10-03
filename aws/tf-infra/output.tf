# CUSTOM NETWORK CONFIGURATION
# The following variables are output from the network module and are used to configure the account

# custom_vpc_id             = ""
# custom_private_subnet_ids = ["", ""]
# custom_sg_id              = ""
# custom_relay_vpce_id      = ""
# custom_workspace_vpce_id  = ""

output "custom_vpc_id" {
  description = "ID of the VPC created for the Databricks infrastructure"
  value       = module.vpc.vpc_id
}

output "custom_private_subnet_ids" {
  description = "IDs of the private subnets within the VPC"
  value       = module.vpc.private_subnets
}

output "custom_sg_id" {
  description = "ID of the security group associated with the workspace"
  value       = aws_security_group.sg.id
}

output "custom_relay_vpce_id" {
  description = "ID of the relay VPC endpoint"
  value       = aws_vpc_endpoint.backend_relay.id
}

output "custom_workspace_vpce_id" {
  description = "ID of the workspace VPC endpoint"
  value       = aws_vpc_endpoint.backend_rest.id
}