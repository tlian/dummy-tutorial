packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a source.
# [WARNING] Please ensure to de-register the AMI and snapshots in AWS to avoid
# incurring charges under your account
source "amazon-ebs" "firstrun-windows" {
  ami_name      = "${var.aws_ami_name}-${local.timestamp}"
  communicator  = "${var.communicator}"
  instance_type = "${var.aws_instance_type}"
  region        = "${var.region}"
  source_ami_filter {
    filters = {
      name = "${var.aws_ami_search_regex}"
      root-device-type = "${var.root_device_type}"
      virtualization-type = "${var.virtualization_type}"
    }
    most_recent = true
    owners = ["${var.aws_ami_owner}"]
  }  
  user_data_file = "${var.user_data_file}"
  winrm_password = "${var.winrm_password}"
  winrm_username = "${var.winrm_user}"
}

# a build block invokes sources and runs provisioning steps on them.
build {
  name    = "${var.packer_build_name}"
  sources = ["source.amazon-ebs.firstrun-windows"]

  provisioner "powershell" {
    environment_vars = ["DEVOPS_LIFE_IMPROVER=PACKER"]
    inline           = ["Write-Host \"WELCOME TO $Env:DEVOPS_LIFE_IMPROVER\"", "Write-Host \"You need to use backtick escapes when using\"", "Write-Host \"characters such as DOLLAR`$ directly in a command\"", "Write-Host \"or in your own scripts.\""]
  }
  provisioner "windows-restart" {
  }
  provisioner "powershell" {
    environment_vars = ["VAR1=A$Dollar", "VAR2=A`Backtick", "VAR3=A'SingleQuote", "VAR4=A\"DoubleQuote"]
    script           = "./sample_script.ps1"
  }
}