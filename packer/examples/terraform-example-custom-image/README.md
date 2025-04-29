╷
│ Error: creating Subnet (Subscription: "e3f15d8c-993f-4cee-9554-a6d3f86a68c5"
│ Resource Group Name: "RG-OPT-QA-TEST"
│ Virtual Network Name: "RG-OPT-QA-Vnet"
│ Subnet Name: "RG-Terraform-snet-in"): performing CreateOrUpdate: unexpected status 404 (404 Not Found) with error: ResourceNotFound: The Resource 'Microsoft.Network/virtualNetworks/RG-OPT-QA-Vnet' under resource group 'RG-OPT-QA-TEST' was not found. For more details please go to https://aka.ms/ARMResourceNotFoundFix
│
│   with azurerm_subnet.internal,
│   on main.tf line 37, in resource "azurerm_subnet" "internal":
│   37: resource "azurerm_subnet" "internal" {
│


╷
│ Error: deleting Virtual Network (Subscription: "e3f15d8c-993f-4cee-9554-a6d3f86a68c5"
│ Resource Group Name: "RG-OPT-QA-TEST"
│ Virtual Network Name: "RG-OPT-QA-Vnet"): performing Delete: unexpected status 400 (400 Bad Request) with error: InUseSubnetCannotBeDeleted: Subnet RG-Terraform-snet-in is in use by /subscriptions/e3f15d8c-993f-4cee-9554-a6d3f86a68c5/resourceGroups/RG-OPT-QA-TEST/providers/Microsoft.Network/networkInterfaces/NIC/ipConfigurations/NICCONFIG and cannot be deleted. In order to delete the subnet, delete all the resources within the subnet. See aka.ms/deletesubnet.

