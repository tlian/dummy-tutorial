# Ensure to set the following Environment variables (i.e. export them via terminal)
# =================================================================================
# export TF_VAR_subscription_id="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
# export TF_VAR_tenant_id="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
# export TF_VAR_client_id="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
# export TF_VAR_client_secret="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
# =================================================================================

variable subscription_id {
    type      = string
    ephemeral = true
    sensitive = true
}

variable tenant_id {
    type      = string
    ephemeral = true
    sensitive = true
}

variable client_id {
    type      = string
    ephemeral = true
    sensitive = true
}

variable client_secret {
    type      = string
    ephemeral = true
    sensitive = true
}

# =============================

variable resource_group_name {
    type    = string
    default = "RG-OPT-QA-TEST"
}

variable region_in_azure {
    type    = string
    default = "eastus"
}

variable azurerm_image_name {
    type    = string
    default = "WindowsServer2019-Packer-20250423032339"
}

variable resource_group_name_of_image {
    type    = string
    default = "myResourceGroup"
}

variable azurerm_network_security_group_name {
    type    = string
    default = "RG-QA-Test-Dev-NSG"
}

variable azurerm_virtual_network_name {
    type    = string
    default = "RG-OPT-QA-Vnet"
}

variable address_space {
    type    = string
    default = "10.0.0.0/16"
}

variable "azurerm_subnet_name" {
    type    = string
    default = "RG-Terraform-snet-in"
}

variable "azurerm_subnet_address_prefixes" {
    type    = string
    default = "10.0.0.0/24"
}
variable "azurerm_network_interface_name" {
    type    = string
    default = "NIC"
}

variable "azurerm_network_interface_ip_configuration_name" {
    type    = string
    default = "nicconfig"
}

variable "private_ip_address_allocation_type" {
    type    = string
    default = "Static"
}

variable "private_ip_address_cidr" {
    type    = string
    default = "10.0.0.16/24"
}

variable "azurerm_virtual_machine_name" {
    type    = string
    default = "AZLXDEVOPS01"
  
}