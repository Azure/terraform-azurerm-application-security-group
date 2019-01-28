# The priority of a rule is unique to the NSG
# therefore we supply an offset for the rules that is calculated from a primary
# And the sum of the number of preceding rules.

locals {
  ingress_with_cidr_blocks_offset = 0
  egress_with_cidr_blocks_offset  = "${length(var.ingress_with_cidr_blocks)}"
  ingress_with_asg_ids_offset     = "${length(var.ingress_with_cidr_blocks)+length(var.egress_with_cidr_blocks)}"
  egress_with_asg_ids_offset      = "${length(var.ingress_with_cidr_blocks)+length(var.egress_with_cidr_blocks)+length(var.ingress_with_asg_ids)}"
}


resource "azurerm_application_security_group" "this" {
  name                = "${format("%s-appsecuritygroup", var.name)}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  tags {
    "environment" = "${var.environment}"
  }
}


resource "azurerm_network_security_rule" "ingress_with_cidr_blocks" {
  count = "${length(var.ingress_with_cidr_blocks)}"

  name                                        = "${format("%s-asg-ingress-cidr-%02d", var.name, count.index)}"
  description                                 = "${lookup(var.ingress_with_cidr_blocks[count.index], "description", "Ingress Rule")}"
  priority                                    = "${format("%03d", count.index+var.priority_offset+local.ingress_with_cidr_blocks_offset)}"
  direction                                   = "Inbound"
  access                                      = "Allow"
  protocol                                    = "${lookup(var.ingress_with_cidr_blocks[count.index], "protocol", "Tcp")}"
  source_port_range                           = "${lookup(var.ingress_with_cidr_blocks[count.index], "source_port_range")}"
  destination_port_range                      = "${lookup(var.ingress_with_cidr_blocks[count.index], "destination_port_range")}"
  source_address_prefixes                     = ["${split(",", lookup(var.ingress_with_cidr_blocks[count.index], "source_address_prefixes", join(",", var.ingress_cidr_blocks)))}"]
  destination_application_security_group_ids  = ["${azurerm_application_security_group.this.id}"]
  resource_group_name                         = "${var.resource_group_name}"
  network_security_group_name                 = "${var.network_security_group_name}"
}

resource "azurerm_network_security_rule" "egress_with_cidr_blocks" {
  count = "${length(var.egress_with_cidr_blocks)}"

  name                                        = "${format("%s-asg-egress--cidr-%s", var.name, count.index)}"
  description                                 = "${lookup(var.egress_with_cidr_blocks[count.index], "description", "Egress Rule")}"
  priority                                    = "${format("%03d", count.index+var.priority_offset+local.egress_with_cidr_blocks_offset)}"
  direction                                   = "Outbound"
  access                                      = "Allow"
  protocol                                    = "${lookup(var.egress_with_cidr_blocks[count.index], "protocol", "Tcp")}"
  source_port_range                           = "${lookup(var.egress_with_cidr_blocks[count.index], "source_port_range")}"
  destination_port_range                      = "${lookup(var.egress_with_cidr_blocks[count.index], "destination_port_range")}"
  destination_address_prefixes                = ["${split(",", lookup(var.egress_with_cidr_blocks[count.index], join(",","destination_address_prefixes"), join(",", var.egress_cidr_blocks)))}"]
  source_application_security_group_ids       = ["${azurerm_application_security_group.this.id}"]
  resource_group_name                         = "${var.resource_group_name}"
  network_security_group_name                 = "${var.network_security_group_name}"
}

resource "azurerm_network_security_rule" "ingress_with_asg_ids" {
  count = "${length(var.ingress_with_asg_ids)}"

  name                                        = "${format("%s-asg-ingress-asgid-%s", var.name, count.index)}"
  description                                 = "${lookup(var.ingress_with_asg_ids[count.index], "description", "Ingress Rule")}"
  priority                                    = "${format("%03d", count.index+var.priority_offset+local.ingress_with_asg_ids_offset)}"
  direction                                   = "Inbound"
  access                                      = "Allow"
  protocol                                    = "${lookup(var.ingress_with_asg_ids[count.index], "protocol", "Tcp")}"
  source_port_range                           = "${lookup(var.ingress_with_asg_ids[count.index], "source_port_range")}"
  destination_port_range                      = "${lookup(var.ingress_with_asg_ids[count.index], "destination_port_range")}"
  source_application_security_group_ids       = ["${split(",", lookup(var.ingress_with_asg_ids[count.index], "source_application_security_group_ids", join(",", var.ingress_with_asg_ids)))}"]
  destination_application_security_group_ids  = ["${azurerm_application_security_group.this.id}"]
  resource_group_name                         = "${var.resource_group_name}"
  network_security_group_name                 = "${var.network_security_group_name}"
}

resource "azurerm_network_security_rule" "egress_with_asg_ids" {
  count = "${length(var.egress_with_asg_ids)}"

  name                                        = "${format("%s-asg-egress-asgid-%s", var.name, count.index)}"
  description                                 = "${lookup(var.egress_with_asg_ids[count.index], "description", "Egress Rule")}"
  priority                                    = "${format("%03d", count.index+var.priority_offset+local.egress_with_asg_ids_offset)}"
  direction                                   = "Outbound"
  access                                      = "Allow"
  protocol                                    = "${lookup(var.egress_with_asg_ids[count.index], "protocol", "Tcp")}"
  source_port_range                           = "${lookup(var.egress_with_asg_ids[count.index], "source_port_range")}"
  destination_port_range                      = "${lookup(var.egress_with_asg_ids[count.index], "destination_port_range")}"
  destination_application_security_group_ids  = ["${split(",", lookup(var.egress_with_asg_ids[count.index], "destination_application_security_group_ids", join(",", var.egress_with_asg_ids)))}"]
  source_application_security_group_ids       = ["${azurerm_application_security_group.this.id}"]
  resource_group_name                         = "${var.resource_group_name}"
  network_security_group_name                 = "${var.network_security_group_name}"
}
