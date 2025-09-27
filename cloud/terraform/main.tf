terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "32830951-59a1-4f02-a298-0318d174d14a"
}

resource "azurerm_resource_group" "fintech_rg" {
  name     = "fintech-rg"
  location = var.azure_location
}

resource "azurerm_virtual_network" "fintech_vnet" {
  name                = "fintech-vnet"
  address_space       = [var.vnet_cidr]
  location            = azurerm_resource_group.fintech_rg.location
  resource_group_name = azurerm_resource_group.fintech_rg.name
}

resource "azurerm_subnet" "fintech_subnet" {
  name                 = "fintech-subnet"
  resource_group_name  = azurerm_resource_group.fintech_rg.name
  virtual_network_name = azurerm_virtual_network.fintech_vnet.name
  address_prefixes     = [var.subnet_cidr]
}

resource "azurerm_network_security_group" "fintech_nsg" {
  name                = "fintech-nsg"
  location            = azurerm_resource_group.fintech_rg.location
  resource_group_name = azurerm_resource_group.fintech_rg.name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTPS"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_public_ip" "fintech_public_ip" {
  name                = "fintech-public-ip"
  location            = azurerm_resource_group.fintech_rg.location
  resource_group_name = azurerm_resource_group.fintech_rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "fintech_nic" {
  name                = "fintech-nic"
  location            = azurerm_resource_group.fintech_rg.location
  resource_group_name = azurerm_resource_group.fintech_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.fintech_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.fintech_public_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "fintech_nic_nsg" {
  network_interface_id      = azurerm_network_interface.fintech_nic.id
  network_security_group_id = azurerm_network_security_group.fintech_nsg.id
}

resource "azurerm_linux_virtual_machine" "fintech_vm" {
  name                = "fintech-vm"
  resource_group_name = azurerm_resource_group.fintech_rg.name
  location            = azurerm_resource_group.fintech_rg.location
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [azurerm_network_interface.fintech_nic.id]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = "latest"
  }
}