# Configure provider
provider "aws" {
  region = "us-east-1"
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
}

# Declare variable 
variable "AWS_ACCESS_KEY" {
  type = string
}
variable "AWS_SECRET_KEY" {
  type = string
}

variable "vpc1_cidr" {
  description = "cidr_block for vpc-1 VPC"
  default     = "10.0.0.0/16"
  type        = string
}

variable "subnet_cidr" {
  description = "cidr for subnet1"
  default     = "10.0.1.0/24"
  type        = string
}

# Create VPC
resource "aws_vpc" "vpc-1" {
    cidr_block = var.vpc1_cidr

    tags = {
      Name = "tlian-dev-vpc"
    }
}

# Create internet gateway
resource "aws_internet_gateway" "internet-gw" {
  vpc_id = aws_vpc.vpc-1.id

  tags = {
    Name = "tlian-internet-gw"
  }
}

# Create route table
resource "aws_route_table" "vpc-1-rt" {
  vpc_id = aws_vpc.vpc-1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gw.id
  }

  tags = {
    Name = "tlian-vpc-1-rt"
  }
}

# Associate subnet to route table
resource "aws_route_table_association" "rt_subnet_association" {
  subnet_id       = aws_subnet.subnet-1.id
  route_table_id  = aws_route_table.vpc-1-rt.id
}

# Create Subnet
resource "aws_subnet" "subnet-1" {
  cidr_block        = var.subnet_cidr
  vpc_id            = aws_vpc.vpc-1.id
  availability_zone = "us-east-1a" 

  tags = {
    Name = "tlian-dev-subnet"
  }
}

# create Network interfaces
resource "aws_network_interface" "nic1" {
  subnet_id       = aws_subnet.subnet-1.id
  private_ips     = ["10.0.1.101"]
  security_groups = [ aws_security_group.allow_ssh.id ]

  tags = {
    Name = "tlian-dev-nic1"
  }
}

resource "aws_network_interface" "nic2" {
  subnet_id       = aws_subnet.subnet-1.id
  private_ips     = ["10.0.1.102"]
  security_groups = [ aws_security_group.allow_ssh.id ]

  tags = {
    Name = "tlian-dev-nic2"
  }
}

resource "aws_network_interface" "nic3" {
  subnet_id       = aws_subnet.subnet-1.id
  private_ips     = ["10.0.1.103"]
  security_groups = [ aws_security_group.allow_ssh.id ]

  tags = {
    Name = "tlian-dev-nic3"
  }
}

# Assign an elastic/public IP to the network interface(s) created
resource "aws_eip" "eip1" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.nic1.id
  associate_with_private_ip = "10.0.1.101"
  depends_on                = [ aws_internet_gateway.internet-gw ]
}

resource "aws_eip" "eip2" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.nic2.id
  associate_with_private_ip = "10.0.1.102"
  depends_on                = [ aws_internet_gateway.internet-gw ]
}

resource "aws_eip" "eip3" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.nic3.id
  associate_with_private_ip = "10.0.1.103"
  depends_on                = [ aws_internet_gateway.internet-gw ]
}

# Create Security Group to allow port 22, 80, 443
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh_traffic"
  description = "Allow ssh traffic"
  vpc_id      = "${aws_vpc.vpc-1.id}"
  
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tlian-allow_ssh"
  }
}

# create VMs
resource "aws_instance" "controlserver" {
  ami               = "ami-0103953a003440c37"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  key_name          = "main-key" 

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.nic1.id
  }

  user_data = <<EOF
              #!/bin/bash
              sudo apt update -y; sudo apt dist-upgrade -y
              EOF

  tags = { 
    Name = "tlian-controlserver" 
  }
}

# create VMs
resource "aws_instance" "ansibleguest1" {
  ami               = "ami-0103953a003440c37"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  key_name          = "main-key" 

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.nic2.id
  }

  user_data = <<EOF
              #!/bin/bash
              sudo apt update -y; sudo apt dist-upgrade -y
              EOF

  tags = { 
    Name = "tlian-ansibleguest1" 
  }
}

resource "aws_instance" "ansibleguest2" {
  ami               = "ami-0103953a003440c37"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  key_name          = "main-key" 

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.nic3.id
  }

  user_data = <<EOF
              #!/bin/bash
              sudo apt update -y; sudo apt dist-upgrade -y
              EOF

  tags = { 
    Name = "tlian-ansibleguest2"
  }
}
