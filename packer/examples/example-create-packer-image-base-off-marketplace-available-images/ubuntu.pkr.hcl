packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~> 2"
    }
  }
}

source "azure-arm" "autogenerated_1" {
  azure_tags = {
    dept = "Platform Engineering"
    task = "Image deployment (test)"
  }

  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  subscription_id = "${var.subscription_id}"
  tenant_id       = "${var.tenant_id}"
  location        = "East US 2"

  # managed_image_name is the name to be given to the newly created image
  managed_image_name = "myPackerImage3"

  # Resource Group to create the image in
  managed_image_resource_group_name = "myResourceGroup"

  ############# WINDOWS FLAVOR : start #############
  os_type         = "Windows"
  image_offer     = "WindowsServer"
  vm_size         = "Standard_D2_v2"
  image_publisher = "MicrosoftWindowsServer"
  image_sku       = "2016-Datacenter"
  communicator    = "winrm"
  winrm_insecure  = true
  winrm_timeout   = "5m"
  winrm_use_ssl   = true
  winrm_username  = "packer"
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
  sources = ["source.azure-arm.autogenerated_1"]

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
      "# If Guest Agent services are installed, make sure that they have started.",
      "foreach ($service in Get-Service -Name RdAgent, WindowsAzureTelemetryService, WindowsAzureGuestAgent -ErrorAction SilentlyContinue) { while ((Get-Service $service.Name).Status -ne 'Running') { Start-Sleep -s 5 } }",

      "& $env:SystemRoot\\System32\\Sysprep\\Sysprep.exe /oobe /generalize /quiet /quit /mode:vm",
      "while($true) { $imageState = Get-ItemProperty HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\State | Select ImageState; if($imageState.ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') { Write-Output $imageState.ImageState; Start-Sleep -s 10  } else { break } }"
    ]
  }
}
