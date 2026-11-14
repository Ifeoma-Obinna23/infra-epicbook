# Server names must be globally unique, so add a random suffix
resource "random_string" "suffix" {
  length  = 5
  upper   = false
  special = false
}

resource "azurerm_private_dns_zone" "mysql" {
  name                = "${var.prefix}.private.mysql.database.azure.com"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "mysql" {
  name                  = "mysql-dns-link"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.mysql.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  registration_enabled  = false
}

resource "azurerm_mysql_flexible_server" "mysql" {
  name                   = "${var.prefix}-mysql-${random_string.suffix.result}"
  location               = azurerm_resource_group.rg.location
  resource_group_name    = azurerm_resource_group.rg.name
  administrator_login    = var.mysql_admin_username
  administrator_password = var.mysql_admin_password
  sku_name               = var.mysql_sku
  version                = var.mysql_version
  backup_retention_days  = 7

  # Private access: the server lives in the delegated subnet, with no public endpoint
  delegated_subnet_id = azurerm_subnet.db.id
  private_dns_zone_id = azurerm_private_dns_zone.mysql.id

  storage {
    size_gb = var.mysql_storage_gb
  }

  depends_on = [azurerm_private_dns_zone_virtual_network_link.mysql]

  lifecycle {
    ignore_changes = [zone]
  }
}