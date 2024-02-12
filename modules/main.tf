resource "aws_vpc" "this" {
  for_each             = var.vpc_parameters
  cidr_block           = each.value.cidr_block
  enable_dns_support   = each.value.enable_dns_support
  enable_dns_hostnames = each.value.enable_dns_hostnames
  tags = merge(each.value.tags, {
    Name : each.key
  })
}

resource "aws_subnet" "this" {
  for_each   = var.subnet_parameters
  vpc_id     = aws_vpc.this[each.value.vpc_name].id
  cidr_block = each.value.cidr_block
  tags = merge(each.value.tags, {
    Name : each.key
  })
}

resource "aws_internet_gateway" "this" {
  for_each = var.igw_parameters
  vpc_id   = aws_vpc.this[each.value.vpc_name].id
  tags = merge(each.value.tags, {
    Name : each.key
  })
}

resource "aws_route_table" "this" {
  for_each = var.rt_parameters
  vpc_id   = aws_vpc.this[each.value.vpc_name].id
  tags = merge(each.value.tags, {
    Name : each.key
  })

  dynamic "route" {
    for_each = each.value.routes
    content {
      cidr_block = route.value.cidr_block
      gateway_id = route.value.use_igw ? aws_internet_gateway.this[route.value.gateway_id].id : route.value.gateway_id
    }
  }
}

resource "aws_route_table_association" "this" {
  for_each       = var.rt_association_parameters
  subnet_id      = aws_subnet.this[each.value.subnet_name].id
  route_table_id = aws_route_table.this[each.value.rt_name].id
}


resource "aws_vpc_endpoint" "endpoint" {
  for_each            = var.endpoint_parameters
  vpc_id              = aws_vpc.this[each.value.vpc_name].id
  service_name        = each.value.service_name
  vpc_endpoint_type   = each.value.endpoint_type
  security_group_ids  = each.value.security_group_ids
  private_dns_enabled = each.value.private_dns_enabled
}


resource "aws_flow_log" "flow_log" {
  for_each        = var.flow_log_parameters
  iam_role_arn    = each.value.iam_role_arn
  log_destination = each.value.log_destination
  traffic_type    = each.value.traffic_type
  vpc_id          = aws_vpc.this[each.value.vpc_name].id
}


resource "aws_network_acl" "nacl" {
  for_each   = var.nacl_parameters
  vpc_id     = aws_vpc.this[each.value.vpc_name].id
  subnet_ids = each.value.subnet_ids
  tags = merge(each.value.tags, {
    Name : each.key
  })

}