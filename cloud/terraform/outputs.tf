output "network_id" {
  description = "The ID of the OpenStack Network"
  value       = openstack_networking_network_v2.fintech_net.id
}

output "subnet_id" {
  description = "The ID of the OpenStack Subnet"
  value       = openstack_networking_subnet_v2.fintech_subnet.id
}

output "security_group_id" {
  description = "The ID of the OpenStack Security Group"
  value       = openstack_networking_secgroup_v2.fintech_secgroup.id
}

output "vm_id" {
  description = "The ID of the OpenStack Virtual Machine"
  value       = openstack_compute_instance_v2.fintech_vm.id
}

output "vm_name" {
  description = "The name of the OpenStack Virtual Machine"
  value       = openstack_compute_instance_v2.fintech_vm.name
}

output "admin_username" {
  description = "The admin username for SSH access"
  value       = var.os_username
}