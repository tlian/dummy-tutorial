packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~> 2"
    }
  }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "azure-arm" "example_build" {
  azure_tags = {
    dept = "Engineering"
    task = "Image deployment (test)"
  }

  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  subscription_id = "${var.subscription_id}"
  tenant_id       = "${var.tenant_id}"
  location        = "${var.location}" # Variablize. This is the Location of Azure and set Default location

  allowed_inbound_ip_addresses = ["73.146.101.162"] # it passed.

  # Network to place the VM in 
  # virtual_network_resource_group_name    = "${var.rg_name}"
  # virtual_network_name                   = "${var.virtual_network_name}"
  # virtual_network_subnet_name            = "${var.virtual_network_subnet_name}"
  private_virtual_network_with_public_ip = true

  # network_interface_id = "/subscriptions/e3f15d8c-993f-4cee-9554-a6d3f86a68c5/resourceGroups/rg-tlian-main/providers/Microsoft.Network/networkInterfaces/tlian-nic-1"
  # network_interface = "tlian-nic-1"

  # network_interface { 
  #   name = "tlian-nic-1"
  # }

  # Try out specified Public IP Address
  # public_ip_resource_group_name = "${var.rg_name}"
  # public_ip_name                = "${var.public_ip_address_name}"
  # network_interface_name        = "${var.network_interface_name}"

  # network_interface {
  #   name                                  = "${var.network_interface_name}" # Not sure if this needs to be pre-created
  #   public_ip_address_name                = "${var.public_ip_address_name}" # Reference the pre-created IP
  #   public_ip_address_resource_group_name = "${var.rg_name}"
  # }

  # managed_image_name is the name to be given to the newly created image
  managed_image_name                = "myPackerImage_custom_${local.timestamp}" # Variablize. This is the name of the new image to be created
  managed_image_resource_group_name = "${var.rg_name}"                          # Variablize. This is the RG the new image will be created in


  ############ Build from custom-managed-image ###############
  # When building custom managed image: the following attributes should NOT be set
  # - image_publisher, 
  # - image_offer
  # - image_sku
  # - image_version

  custom_managed_image_name                = "${var.custom_managed_image_name}" # Need to be variablize
  custom_managed_image_resource_group_name = "${var.rg_name}"                   # Need to be variablize
  ##############################################################

  ############# WINDOWS FLAVOR : start #############
  # When building with custom-managed-image, 
  # Comment out the following: image_offer, image_publisher, image_sku
  # image_offer     = "WindowsServer"
  # image_publisher = "MicrosoftWindowsServer"
  # image_sku       = "2016-Datacenter"

  os_type      = "Windows"
  vm_size      = "Standard_D2_v2"
  communicator = "winrm"

  winrm_insecure = true
  winrm_timeout  = "5m"
  winrm_use_ssl  = true
  winrm_username = "packer"
  # winrm_password = "passw0rdPack3r"
  winrm_password = "FalsePassw0rd!"
  ############# WINDOWS FLAVOR : end #############

  # ############# LINUX FLAVOR : start #############
  # LINUX flavor
  # os_type                           = "Linux"
  # image_offer                       = "0001-com-ubuntu-server-jammy"
  # vm_size                           = "Standard_DS2_v2"
  # image_publisher                   = "canonical"
  # image_sku                         = "22_04-lts"
  # ############# LINUX FLAVOR : end #############
}

build {
  sources = ["source.azure-arm.example_build"]

  # network_interface_resource_group = "rg-tlian-main"

  # ############# LINUX FLAVOR : start #############
  # provisioner "shell" {
  #   execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
  #   inline          = ["apt-get update", "apt-get upgrade -y", "apt-get -y install nginx", "/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"]
  #   inline_shebang  = "/bin/sh -x"
  # }
  ############ LINUX FLAVOR : end #############

  ############# WINDOWS FLAVOR : start #############
  provisioner "powershell" {
    inline = [
      "Write-Host \"Check if previous metadata is there...\"",
      "ls C:\\Windows\\Temp",

      "Write-Host \"Checking current user...\"",
      "$Env:UserName",
      "ls",

      "New-Item -ItemType Directory C:\\Windows\\Temp\\tlian-test-dir -ErrorAction SilentlyContinue",
      "Add-Content -Path \"C:\\Windows\\Temp\\tlian-test.txt\" -Value \"This is the new content: $(date)\"",

      "Write-Host \"Check WinRM service...\"",
      "Get-Service -Name WinRm",

      "Write-Host \"Reading C:\\Windows\\Temp\\tlian-test.txt\"",
      "Get-Content -Path \"C:\\Windows\\Temp\\tlian-test.txt\"",

      "# If Guest Agent services are installed, make sure that they have started.",
      "foreach ($service in Get-Service -Name RdAgent, WindowsAzureTelemetryService, WindowsAzureGuestAgent -ErrorAction SilentlyContinue) { while ((Get-Service $service.Name).Status -ne 'Running') { Start-Sleep -s 5 } }",

      " # Sysprep (generalize) the VM before creating the final image.",
      "& $env:SystemRoot\\System32\\Sysprep\\Sysprep.exe /oobe /generalize /quiet /quit /mode:vm",
      "while($true) { $imageState = Get-ItemProperty HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\State | Select ImageState; if($imageState.ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') { Write-Output $imageState.ImageState; Start-Sleep -s 10  } else { break } }"
    ]
  }
}
