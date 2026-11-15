variable "location" {
  description = "Azure region for all EpicBook resources"
  type        = string
  default     = "eastus"
}

variable "prefix" {
  description = "Prefix used in resource names"
  type        = string
  default     = "epicbook"
}

variable "vnet_cidr" {
  type    = string
  default = "10.20.0.0/16"
}

variable "frontend_subnet_cidr" {
  type    = string
  default = "10.20.1.0/24"
}

variable "backend_subnet_cidr" {
  type    = string
  default = "10.20.2.0/24"
}

variable "db_subnet_cidr" {
  type    = string
  default = "10.20.3.0/24"
}

variable "ssh_allowed_cidrs" {
  description = "Sources allowed to SSH: my IP range and the Azure DevOps agent VM"
  type        = list(string)
  default     = ["102.90.0.0/16", "4.154.0.247/32"]
}

variable "vm_size" {
  description = "VM size available in the subscription and region"
  type        = string
  default     = "Standard_D2als_v7"
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "ssh_public_key_path" {
  description = "Public key placed on both VMs (relative to this folder)"
  type        = string
  default     = "keys/epicbook_rsa.pub"
}

variable "backend_app_port" {
  type    = number
  default = 8080
}

variable "mysql_admin_username" {
  description = "Supplied by the pipeline from the secured variable group"
  type        = string
}

variable "mysql_admin_password" {
  description = "Supplied by the pipeline from the secured variable group"
  type        = string
  sensitive   = true
}

variable "mysql_sku" {
  type    = string
  default = "B_Standard_B1ms"
}

variable "mysql_version" {
  type    = string
  default = "8.0.21"
}

variable "mysql_storage_gb" {
  type    = number
  default = 20
}
variable "disk_controller_type" {
  description = "v6/v7 VM sizes require the NVMe disk controller"
  type        = string
  default     = "NVMe"
}
