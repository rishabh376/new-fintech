output "vpc_id" {
  description = "The ID of the AWS VPC"
  value       = aws_vpc.fintech_vpc.id
}

output "subnet_id" {
  description = "The ID of the AWS Subnet"
  value       = aws_subnet.fintech_subnet.id
}

output "security_group_id" {
  description = "The ID of the AWS Security Group"
  value       = aws_security_group.fintech_sg.id
}

output "instance_id" {
  description = "The ID of the AWS EC2 Instance"
  value       = aws_instance.fintech_vm.id
}

output "instance_public_ip" {
  description = "The public IP of the AWS EC2 Instance"
  value       = aws_instance.fintech_vm.public_ip
}