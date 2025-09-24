variable "os_username" {}
variable "os_password" {}
variable "os_auth_url" {}
variable "os_tenant_name" {}
variable "os_region" {}
variable "subnet_cidr" { default = "10.0.1.0/24" }
variable "gateway_ip" { default = "10.0.1.1" }
variable "admin_ssh_public_key" {}
variable "image_name" { default = "Ubuntu 18.04" }
variable "flavor_name" { default = "m1.small" }