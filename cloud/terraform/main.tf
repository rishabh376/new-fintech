terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "fintech_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "fintech-vpc"
  }
}

resource "aws_subnet" "fintech_subnet" {
  vpc_id                  = aws_vpc.fintech_vpc.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.aws_availability_zone
  tags = {
    Name = "fintech-subnet"
  }
}

resource "aws_security_group" "fintech_sg" {
  name        = "fintech-sg"
  description = "Fintech security group"
  vpc_id      = aws_vpc.fintech_vpc.id

  ingress {
    description      = "Allow SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Allow HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Allow HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "fintech-sg"
  }
}

resource "aws_key_pair" "fintech_key" {
  key_name   = "fintech-key"
  public_key = var.admin_ssh_public_key
}

resource "aws_instance" "fintech_vm" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.fintech_subnet.id
  vpc_security_group_ids = [aws_security_group.fintech_sg.id]
  key_name               = aws_key_pair.fintech_key.key_name

  tags = {
    Name = "fintech-vm"
  }
}