# Usage
-----

The module accepts a list of ingress/egress rules that are used to create network security group rules referencing source addresses or application security groups.  

```hcl
module "application_security_group" {
  source = "git::ssh:git@github.com:Azure/terraform-azurerm-application-security-group.git"
  name                          = "web-service"
  location                      = "centralus"
  resource_group_name           = "myresourcegroup"
  network_security_group_name   = "mynetworksecuritygroup"
  ingress_with_cidr_blocks      = [{
      source_port_range       = 8080
      destination_port_range  = 8090
      protocol                = "Tcp"
      description             = "Web-service ports"
      source_address_prefixes = "10.10.0.0/16"
    }]
}
```


# Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.microsoft.com.

When you submit a pull request, a CLA-bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.
