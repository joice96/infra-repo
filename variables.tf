# variables.tf

variable "vpc_parameters" {
  description = "VPC parameters"
  type = map(object({
    cidr_block           = string
    enable_dns_support   = optional(bool)
    enable_dns_hostnames = optional(bool)
    tags                 = optional(map(string))
  }))
  default = {}
}

variable "subnet_parameters" {
  description = "Subnet parameters"
  type = map(object({
    cidr_block = string
    vpc_name   = string
    tags       = optional(map(string))
  }))
  default = {}
}

variable "igw_parameters" {
  description = "IGW parameters"
  type = map(object({
    vpc_name = string
    tags     = optional(map(string))
  }))
  default = {}
}

variable "rt_parameters" {
  description = "RT parameters"
  type = map(object({
    vpc_name = string
    tags     = optional(map(string))
    routes = optional(list(object({
      cidr_block = string
      use_igw    = optional(bool)
      gateway_id = string
    })))
  }))
  default = {}
}


variable "rt_association_parameters" {
  description = "RT association parameters"
  type = map(object({
    subnet_name = string
    rt_name     = string
  }))
  default = {}
}

variable "endpoint_parameters" {
  description = "Endpoint parameters"
  type = map(object({
    vpc_name            = string
    service_name        = string
    security_group_name = string
    tags                = optional(map(string))
  }))
  default = {}
}

variable "flow_log_parameters" {
  description = "Flow log parameters"
  type = map(object({
    vpc_name       = string
    log_group_name = string
    tags           = optional(map(string))
  }))
  default = {}
}

variable "nacl_parameters" {
  description = "Network ACL parameters"
  type = map(object({
    vpc_name = string
    tags     = optional(map(string))
    ingress = optional(list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      rule_action = string
      cidr_block  = string
    })))
    egress = optional(list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      rule_action = string
      cidr_block  = string
    })))
  }))
  default = {}
}
