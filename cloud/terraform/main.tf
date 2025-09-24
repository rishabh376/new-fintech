terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = ">= 1.51.0"
    }
  }
}

provider "openstack" {
  user_name   = var.os_username
  tenant_name = var.os_tenant_name
  password    = var.os_password
  auth_url    = var.os_auth_url
  region      = var.os_region
}

resource "openstack_networking_network_v2" "fintech_net" {
  name = "fintech-net"
}

resource "openstack_networking_subnet_v2" "fintech_subnet" {
  name            = "fintech-subnet"
  network_id      = openstack_networking_network_v2.fintech_net.id
  cidr            = var.subnet_cidr
  ip_version      = 4
  gateway_ip      = var.gateway_ip
}

resource "openstack_compute_keypair_v2" "fintech_key" {
  name       = "fintech-key"
  public_key = var.admin_ssh_public_key
}

resource "openstack_compute_instance_v2" "fintech_vm" {
  name            = "fintech-vm"
  image_name      = var.image_name
  flavor_name     = var.flavor_name
  key_pair        = openstack_compute_keypair_v2.fintech_key.name
  security_groups = [openstack_networking_secgroup_v2.fintech_secgroup.name]

  network {
    uuid = openstack_networking_network_v2.fintech_net.id
  }
}

resource "openstack_networking_secgroup_v2" "fintech_secgroup" {
  name = "fintech-secgroup"
}

resource "openstack_networking_secgroup_rule_v2" "allow_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.fintech_secgroup.id
}

resource "openstack_networking_secgroup_rule_v2" "allow_http" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.fintech_secgroup.id
}

resource "openstack_networking_secgroup_rule_v2" "allow_https" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.fintech_secgroup.id
}