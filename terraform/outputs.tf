output "app_public_ip" {
  description = "Frontend VM public IP for browser users"
  value       = azurerm_public_ip.vm["frontend"].ip_address
}

output "backend_ansible_host" {
  description = "Backend management address used by Ansible"
  value       = azurerm_public_ip.vm["backend"].ip_address
}

output "backend_private_ip" {
  description = "Backend private IP used by Nginx"
  value       = azurerm_network_interface.vm["backend"].private_ip_address
}

output "mysql_fqdn" {
  description = "Private MySQL hostname"
  value       = azurerm_mysql_flexible_server.mysql.fqdn
}

output "frontend_private_ip" {
  value = azurerm_network_interface.vm["frontend"].private_ip_address
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}