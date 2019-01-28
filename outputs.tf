output "asg_name" {
  value = "${format("%s-appsecuritygroup", var.name)}"
}

output "asg_id" {
  value = "${azurerm_application_security_group.this.id}"
}
