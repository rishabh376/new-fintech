provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "fintech_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "FintechVPC"
    Environment = var.environment
  }
}

resource "aws_subnet" "fintech_subnet" {
  vpc_id                  = aws_vpc.fintech_vpc.id
  cidr_block              = var.subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "FintechSubnet"
    Environment = var.environment
  }
}

resource "aws_security_group" "fintech_sg" {
  name        = "FintechSG"
  description = "Allow HTTP and HTTPS"
  vpc_id      = aws_vpc.fintech_vpc.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "FintechSG"
    Environment = var.environment
  }
}

resource "aws_instance" "fintech_app" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.fintech_subnet.id
  security_group_ids          = [aws_security_group.fintech_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "FintechAppInstance"
    Environment = var.environment
  }
}

output "vpc_id" {
  value = aws_vpc.fintech_vpc.id
}

output "subnet_id" {
  value = aws_subnet.fintech_subnet.id
}

output "security_group_id" {
  value = aws_security_group.fintech_sg.id
}

output "instance_id" {
  value = aws_instance.fintech_app.id
}