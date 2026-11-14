locals {
  vms = {
    frontend = { subnet_id = azurerm_subnet.frontend.id }
    backend  = { subnet_id = azurerm_subnet.backend.id }
  }
}

resource "azurerm_public_ip" "vm" {
  for_each            = local.vms
  name                = "pip-${var.prefix}-${each.key}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "vm" {
  for_each            = local.vms
  name                = "nic-${var.prefix}-${each.key}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = each.value.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm[each.key].id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each                        = local.vms
  name                            = "vm-${var.prefix}-${each.key}"
  location                        = azurerm_resource_group.rg.location
  resource_group_name             = azurerm_resource_group.rg.name
  size                            = var.vm_size
  admin_username                  = var.admin_username
  disable_password_authentication = true
  network_interface_ids           = [azurerm_network_interface.vm[each.key].id]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file("${path.module}/${var.ssh_public_key_path}")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  tags = {
    role = each.key
  }
}