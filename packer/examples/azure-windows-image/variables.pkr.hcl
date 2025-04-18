variable "azure_client_id" {
  type    = string
  default = env("AZURE_CLIENT_ID")
}

variable "azure_client_secret" {
  type    = string
  default = env("AZURE_CLIENT_SECRET")
}

variable "azure_subscription_id" {
  type    = string
  default = env("AZURE_SUBSCRIPTION_ID")
}

variable "azure_tenant_id" {
  type    = string
  default = env("AZURE_TENANT_ID")
}

variable "azure_region" {
  type    = string
  default = "eastus"
}

variable "azure_resource_group" {
  type    = string
  default = "myResourceGroup"
}

variable "image_name" {
  type    = string
  default = "WindowsServer2019-Packer"
}

variable "vm_size" {
  type    = string
  default = "Standard_DS1_v2"
}

variable "communicator" {
  type    = string
  default = "winrm"
}

variable "image_offer" {
  type    = string
  default = "WindowsServer"
}

variable "image_publisher" {
  type    = string
  default = "MicrosoftWindowsServer"
}

variable "image_sku" {
  type    = string
  default = "2019-Datacenter"
}

variable "os_type" {
  type    = string
  default = "Windows"
}

variable "winrm_timeout" {
  type    = string
  default = "3m"
}

variable "winrm_username" {
  type    = string
  default = "packer"
}