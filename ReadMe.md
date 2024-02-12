# VPC Module Infra

## Code Explanation : 

`modules/main.tf`
`aws_vpc`: This block defines the creation of Virtual Private Cloud (VPC) resources. It iterates over a map of VPC parameters provided by var.vpc_parameters, creating a VPC for each set of parameters specified. It sets the CIDR block, DNS support, DNS hostnames, and tags for each VPC.

`aws_subnet`: This block creates subnets within the VPCs defined earlier. It iterates over a map of subnet parameters provided by var.subnet_parameters, associating each subnet with its respective VPC based on the vpc_name. It sets the CIDR block and tags for each subnet.

`aws_internet_gateway`: This block creates internet gateways (IGW) and attaches them to the respective VPCs. It iterates over a map of IGW parameters provided by var.igw_parameters, associating each IGW with its respective VPC based on the vpc_name. It sets tags for each IGW.

`aws_route_table`: This block creates route tables for the VPCs. It iterates over a map of route table parameters provided by var.rt_parameters, associating each route table with its respective VPC based on the vpc_name. It sets tags for each route table and dynamically creates routes specified in the routes parameter.

`aws_route_table_association`: This block associates route tables with subnets. It iterates over a map of route table association parameters provided by var.rt_association_parameters, associating each route table with its respective subnet based on the subnet_name and rt_name.

`aws_vpc_endpoint`: This block creates VPC endpoints within the VPCs. It iterates over a map of endpoint parameters provided by var.endpoint_parameters, associating each endpoint with its respective VPC based on the vpc_name. It sets the service name, endpoint type, security group IDs, and whether private DNS is enabled for each endpoint.

`aws_flow_log`: This block creates flow logs for the VPCs. It iterates over a map of flow log parameters provided by var.flow_log_parameters, associating each flow log with its respective VPC based on the vpc_name. It sets the IAM role ARN, log destination, and traffic type for each flow log.

`aws_network_acl`: This block creates network access control lists (NACLs) for the VPCs. It iterates over a map of NACL parameters provided by var.nacl_parameters, associating each NACL with its respective VPC based on the vpc_name. It sets subnet IDs and tags for each NACL.

`modules/outputs.tf`

output "vpcs": This output provides information about the created VPCs, including their CIDR blocks and IDs.

output "vpc_id": This output provides the ID of a specific VPC named "vpc1".

output "subnet_ids": This output provides a list of subnet IDs created based on the provided subnet parameters.

output "endpoint_ids": This output provides IDs of the created VPC endpoints.

output "flow_log_ids": This output provides IDs of the created flow logs.

output "nacl_ids": This output provides IDs of the created network ACLs.

`modules/variables.tf`

This file defines the input variables required by the module, including parameters for VPC, subnets, IGW, route tables, route table associations, endpoints, flow logs, and NACLs. Each variable has a description and type specified. Default values are provided where applicable.
