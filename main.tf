variable "location" {
    type = string
    description = "Location of resource"
}

variable "resource_group_name" {
    type = string
  description = "Resource group name"
}

variable "subnet_id" {
    type = string
}

variable "private_connection_resource_id" {
    type = string
}


variable "subresource_names" {
  type = list(string)
  description = ["postgresqlServer"]
}


// Sets up the private endpoint for the Postgresql server
//**********************************************************************************************
resource "azurerm_private_endpoint" "endpoint" {
  count               = length(var.subnet_ids)
  name                = "${local.private_endpoint_name}-${count.index}"
  location            = var.rg_location
  resource_group_name = var.resource_group_name
  subnet_id           = element(var.subnet_ids, count.index)

  private_service_connection {
    name                           = local.postgresql_name
    private_connection_resource_id = azurerm_postgresql_server.postgresql.id
    is_manual_connection           = false
    subresource_names              = var.subresource_names
  }
}
//**********************************************************************************************