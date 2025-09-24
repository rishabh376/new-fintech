variable "azure_location" {
  description = "The Azure region to deploy resources"
  type        = string
  default     = "eastus"
}

variable "vnet_cidr" {
  description = "The CIDR block for the Azure Virtual Network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "The CIDR block for the Azure Subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "environment" {
  description = "The environment tag for resources"
  type        = string
  default     = "dev"
}

variable "vm_size" {
  description = "The size of the Azure Virtual Machine"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "azureuser"
}

variable "admin_ssh_public_key" {
  description = "SSH public key for the VM admin user"
  type        = string
}

variable "image_publisher" {
  description = "Publisher of the VM image"
  type        = string
  default     = "Canonical"
}

variable "image_offer" {
  description = "Offer of the VM image"
  type        = string
  default     = "UbuntuServer"
}

variable "image_sku" {
  description = "SKU of the VM image"
  type        = string
  default     = "18.04-LTS"
}