variable "aws_region" { default = "us-east-1" }
variable "aws_availability_zone" { default = "us-east-1a" }
variable "vpc_cidr" { default = "10.0.0.0/16" }
variable "subnet_cidr" { default = "10.0.1.0/24" }
variable "admin_ssh_public_key" {}
variable "ami_id" { default = "ami-0c94855ba95c71c99" }
variable "instance_type" { default = "t2.micro" }