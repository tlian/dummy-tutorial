# Configure the Microsoft Azure Provider
provider "azurerm" {
    features {}
    subscription_id = "${var.subscription_id}"
    client_id       = "${var.client_id}"
    client_secret   = "${var.client_secret}"
    tenant_id       = "${var.tenant_id}"
}

# tlian
# This resource will destroy (potentially immediately) after null_resource.next
resource "null_resource" "previous" {}

resource "time_sleep" "wait_60_seconds" {
  depends_on = [null_resource.previous]

  create_duration = "60s"
}

# Locate the existing custom/golden image
data "azurerm_image" "search" {
  name                = "WindowsServer2019-Packer-20250418195908"
  resource_group_name = "myResourceGroup"
}

# Create a Resource Group for the new Virtual Machine.
resource "azurerm_resource_group" "main" {
  name     = "RG-OPT-QA-TEST"
  location = "eastus"
}

# Create a Network Security Group with some rules
resource "azurerm_network_security_group" "main" {
  name                = "RG-QA-Test-Dev-NSG"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"

  security_rule {
    name                       = "allow_SSH"
    description                = "Allow SSH access"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create virtual network
resource "azurerm_virtual_network" "my_terraform_network" {
  depends_on           = [ azurerm_resource_group.main, time_sleep.wait_60_seconds ]
  name                = "RG-OPT-QA-Vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}


# Create a Subnet within the Virtual Network
resource "azurerm_subnet" "internal" {
  depends_on           = [ azurerm_resource_group.main, azurerm_virtual_network.my_terraform_network, time_sleep.wait_60_seconds ]
  name                 = "RG-Terraform-snet-in"
  virtual_network_name = "RG-OPT-QA-Vnet"
  resource_group_name  = "${azurerm_resource_group.main.name}"
  address_prefixes     = ["10.0.0.0/24"] # tlian
}

# Create a network interface for VMs and attach the PIP and the NSG
resource "azurerm_network_interface" "main" {
  depends_on           = [ azurerm_resource_group.main, azurerm_subnet.internal ]
  name                      = "NIC"
  location                  = "${azurerm_resource_group.main.location}"
  resource_group_name       = "${azurerm_resource_group.main.name}"
#   network_security_group_id = "${azurerm_network_security_group.main.id}" # tlian

  ip_configuration {
    name                          = "nicconfig"
    subnet_id                     = "${azurerm_subnet.internal.id}"
    private_ip_address_allocation = "Static"
    private_ip_address            = "${cidrhost("10.0.0.16/24", 4)}"
  }
}

# Create a new Virtual Machine based on the Golden Image
resource "azurerm_virtual_machine" "vm" {
  depends_on                       = [ azurerm_resource_group.main ]
  name                             = "AZLXDEVOPS01"
  location                         = "${azurerm_resource_group.main.location}"
  resource_group_name              = "${azurerm_resource_group.main.name}"
  network_interface_ids            = ["${azurerm_network_interface.main.id}"]
  vm_size                          = "Standard_DS12_v2"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    id = "${data.azurerm_image.search.id}"
  }

  storage_os_disk {
    name              = "AZLXDEVOPS01-OS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
}

  os_profile {
    computer_name  = "APPVM"
    admin_username = "devopsadmin"
    admin_password = "Cssladmin#2019"
  }

  os_profile_windows_config {
    provision_vm_agent  = false
  }
}