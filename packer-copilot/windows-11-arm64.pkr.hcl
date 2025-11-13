packer {
  required_plugins {
    vmware = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/vmware"
    }
  }
}

variable "iso_url" {
  type    = string
  default = "file:///Users/thawngzapumlian/Downloads/iso-images/Windows/Win11_24H2_English_Arm64.iso"
}

variable "iso_checksum" {
  type    = string
  default = "sha256:57d1dfb2c6690a99fe99226540333c6c97d3fd2b557a50dfe3d68c3f675ef2b0"
}

variable "autounattend" {
  type    = string
  default = "answer_files/Autounattend.xml"
}

variable "output_dir" {
  type    = string
  default = "output-win11-arm64-fusion"
}

variable "winrm_username" {
  type    = string
  default = "packer"
}

variable "winrm_password" {
  type    = string
  default = "P@ssw0rd!"
}

source "vmware-iso" "win11_arm64" {
  # ISO and output
  iso_url            = var.iso_url
  iso_checksum       = var.iso_checksum
  # iso_checksum_type  = "sha256"
  output_directory   = var.output_dir

  # VM hardware
  vm_name            = "win11-arm64"
  guest_os_type      = "otherGuest64"    # Generic 64-bit guest; Fusion will run ARM64 by default on Apple Silicon
  # guest_os_type      = "windows11_64Guest"
  disk_size          = 65536             # 64 GB
  memory             = 4096
  cpus               = 2

  # EFI firmware for ARM64
  firmware           = "efi"
  vmx_data = {
    # "guestOS"              = "other64Arm"  # override if Fusion on M1/M2 requires a specific ARM64 guest identifier
    "firmware"             = "efi"
    # "ethernet0.virtualDev" = "e1000"       # or vmxnet3
    "bios.bootDelay"       = "5000"
    # "guestOS" = "other64Arm" #tlian
  }

  # Networking
  # network_adapters    = ["nat"]

  # Unattended install via floppy
  floppy_files        = [ var.autounattend ]
  boot_wait           = "10s"
  boot_command        = [
    "<esc><wait>",      # Hit any key to boot from ISO
    "c<enter><wait>"
  ]

  # Communicator and tools
  communicator        = "winrm"
  winrm_username      = var.winrm_username
  winrm_password      = var.winrm_password
  winrm_insecure      = true
  winrm_timeout       = "1h"
  tools_upload_flavor = "windows"
  # vmrun_command_timeout = "1h"

  # Graceful shutdown
  shutdown_command    = "shutdown /s /t 10 /f /d p:2:4 /c \"Packer Shutdown\""
}

build {
  sources = ["source.vmware-iso.win11_arm64"]

  provisioner "windows-shell" {
    inline = [
      "Write-Host 'Disabling UAC…'",
      "Set-ItemProperty -Path HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\System -Name EnableLUA -Value 0",
      "Write-Host 'Installing Chocolatey…'",
      "Set-ExecutionPolicy Bypass -Scope Process -Force",
      "irm https://chocolatey.org/install.ps1 | iex"
    ]
  }

  provisioner "windows-restart" {
    restart_timeout = "10m"
  }
}