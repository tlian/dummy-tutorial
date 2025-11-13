variable "client_id" {
  default = env("AZURE_CLIENT_ID")
}

variable "client_secret" {
  default = env("AZURE_CLIENT_SECRET")
}

variable "subscription_id" {
  default = env("AZURE_SUBSCRIPTION_ID")
}

variable "tenant_id" {
  default = env("AZURE_TENANT_ID")
}

variable "location" {
  default = "East US 2"
}

variable "rg_name" {
  default = "rg-tlian-main"
}

variable image_name {
  default = "myPackerImage"
}

variable custom_managed_image_name {
  # default = "myPackerImage_custom"
  # default = "myPackerImage_custom_20250516010130"
  # default = "myPackerImage_custom_20250517141731"
  # default = "myPackerImage_custom_20250517142710"
  default = "myPackerImage_custom_20250517152702"
}

# Networks
variable virtual_network_resource_group_name {
  default = "rg-tlian-main"
}

variable virtual_network_name {
  default = "tlian-vnet-1"
}

variable virtual_network_subnet_name {
  default = "tlian-subnet-1"
}

variable public_ip_address_name {
  default = "tlian-public-ip"
}

variable network_interface_name {
  default = "tlian-nic-1"
}