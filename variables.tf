variable "name" {
  default = ""
}

variable "location" {
  default = ""
}

variable "resource_group_name" {
  default = ""
}

variable "network_security_group_name" {
  default = ""
}

# The Priority for the rule is unique to the NSG, therefore we need to offset them

variable "priority_offset" {
  default = 200
}

# ingress_with_cidr_blocks = [
#   {
#     source_port_range   = 8080
#     destination_port_range     = 8090
#     protocol    = "Tcp"
#     description = "User-service ports"
#     source_address_prefixes = "10.10.0.0/16"
#   }]

variable "ingress_with_cidr_blocks" {
  description = "List of ingress rules to create where 'source_address_prefixes' is used"
  default     = []
  type        = "list"
}

variable "ingress_cidr_blocks" {
  description = "List of IPv4 CIDR ranges to use on all ingress rules"
  default     = []
}

# egress_with_cidr_blocks = [
#   {
#     source_port_range   = 8080
#     destination_port_range     = 8090
#     protocol    = "Tcp"
#     description = "User-service ports"
#     destination_address_prefixes = "10.10.0.0/16"
#   }]

variable "egress_with_cidr_blocks" {
  description = "List of egress rules to create where 'destination_address_prefixes' is used"
  default     = []
  type        = "list"
}

variable "egress_cidr_blocks" {
  description = "List of IPv4 CIDR ranges to use on all egress rules"
  default     = []
}

# ingress_with_cidr_blocks = [
#   {
#     source_port_range   = 8080
#     destination_port_range     = 8090
#     protocol    = "Tcp"
#     description = "User-service ports"
#     source_application_security_group_ids = "asg_id"
#   }]

variable "ingress_with_asg_ids" {
  description = "List of ingress rules to create where 'source_application_security_group_ids' is used"
  default     = []
  type        = "list"
}

# egress_with_cidr_blocks = [
#   {
#     source_port_range   = 8080
#     destination_port_range     = 8090
#     protocol    = "Tcp"
#     description = "User-service ports"
#     destination_application_security_group_ids = "asg_id"
#   }]

variable "egress_with_asg_ids" {
  description = "List of ingress rules to create where 'destination_application_security_group_ids' is used"
  default     = []
  type        = "list"
}

variable "environment" {
  default = ""
}
