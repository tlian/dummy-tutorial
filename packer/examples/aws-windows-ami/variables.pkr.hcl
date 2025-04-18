variable "region" {
  type    = string
  default = "us-east-2"
}

variable "aws_instance_type" {
    type    = string
    default = "t2.micro"
}

variable "aws_ami_name" {
    type    = string
    default = "packer-windows-demo"
}

variable "aws_ami_search_regex" {
    type    = string
    default = "Windows_Server-2019-English-Full-Base-*"
}

variable "communicator" {
    type    = string
    default = "winrm"
}

variable "root_device_type" {
    type    = string
    default = "ebs"
}

variable "virtualization_type" {
    type    = string
    default = "hvm"
}

variable "aws_ami_owner" {
    type    = string
    default = "amazon"
}

variable "user_data_file" {
    type    = string
    default = "./bootstrap_win.txt"
}

variable "packer_build_name" {
    type    = string
    default = "learn-packer"
}

variable "winrm_user" {
    sensitive    = true
    default      = env("WINRM_USER")
}

variable "winrm_password" {
    sensitive    = true
    default      = env("WINRM_PASSWORD")
}
