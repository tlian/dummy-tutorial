packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~> 2"
    }
  }
}

#---------- Variables ---------------#
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
  default = "rg-tlian-main-2"
}

variable image_name {
  default = "tlian-packer-image-linux"
}
#--------------------------------------#

source "azure-arm" "linux_image" {
  azure_tags = {
    dept = "Engineering"
    task = "Image deployment"
  }
  tenant_id       = "${var.tenant_id}"
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"

  image_offer                       = "0001-com-ubuntu-server-jammy"
  image_publisher                   = "canonical"
  image_sku                         = "22_04-lts"
  location                          = "East US 2"
  managed_image_name                = "tlianPackerImageLinux-2"
  managed_image_resource_group_name = "rg-tlian-main-2"
  os_type                           = "Linux"

  vm_size = "Standard_DS2_v2"
}

build {
  sources = ["source.azure-arm.linux_image"]

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
    inline = [
      # echo execute_command,
      "echo \"tlian-Tlian--> {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'\"",
      # Update and upgrade the system,
      "apt-get update",
      "apt-get upgrade -y",
      "echo \"tlian-Tlian--> Installing dialog\"",
      # "apt-get install dialog" was to omit uncessary warning messages for Dialog,
      "apt-get install dialog -y",
      # Install nginx,
      "apt-get -y install nginx",
      # Create Image & Deprovision vm (waagent is Azure specific tool)
      "/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"
    ]
    inline_shebang = "/bin/sh -x"
  }

}