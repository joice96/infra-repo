output "vpcs" {
  description = "VPC Outputs"
  value       = { for vpc in aws_vpc.this : vpc.tags.Name => { "cidr_block" : vpc.cidr_block, "id" : vpc.id } }
}

output "vpc_id" {
  value = aws_vpc.this["vpc1"].id
}

output "subnet_ids" {
  value = [for subnet_name, subnet in var.subnet_parameters : aws_subnet.this[subnet_name].id]
}


output "endpoint_ids" {
  description = "IDs of the created VPC endpoints"
  value       = [for endpoint in aws_vpc_endpoint.endpoint : endpoint.id]
}

output "flow_log_ids" {
  description = "IDs of the created flow logs"
  value       = [for flow_log in aws_flow_log.flow_log : flow_log.id]
}

output "nacl_ids" {
  description = "IDs of the created network ACLs"
  value       = [for nacl in aws_network_acl.nacl : nacl.id]
}
