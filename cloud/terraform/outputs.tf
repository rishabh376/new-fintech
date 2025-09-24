output "vnet_id" {
  description = "The ID of the Azure Virtual Network"
  value       = azurerm_virtual_network.fintech_vnet.id
}

output "subnet_id" {
  description = "The ID of the Azure Subnet"
  value       = azurerm_subnet.fintech_subnet.id
}

output "nsg_id" {
  description = "The ID of the Azure Network Security Group"
  value       = azurerm_network_security_group.fintech_nsg.id
}

output "vm_id" {
  description = "The ID of the Azure Virtual Machine"
  value       = azurerm_linux_virtual_machine.fintech_vm.id
}

output "public_ip_address" {
  description = "The public IP address of the VM"
  value       = azurerm_public_ip.fintech_public_ip.ip_address
}

output "admin_username" {
  description = "The admin username for SSH access"
  value       = var.admin_username
}