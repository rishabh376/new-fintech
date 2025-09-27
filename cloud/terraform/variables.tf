variable "azure_location" {
  default = "eastus"
}
variable "vnet_cidr" {
  default = "10.0.0.0/16"
}
variable "subnet_cidr" {
  default = "10.0.1.0/24"
}
variable "vm_size" {
  default = "Standard_B1s"
}
variable "admin_username" {
  default = "azureuser"
}
variable "admin_ssh_public_key" {}
variable "image_publisher" {
  default = "Canonical"
}
variable "image_offer" {
  default = "UbuntuServer"
}
variable "image_sku" {
  default = "18.04-LTS"
}