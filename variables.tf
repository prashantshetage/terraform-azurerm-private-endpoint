// Required Variables
variable "resource_group_name" {
  type        = string
  description = "(Required) Specifies the Name of the Resource Group within which the Private Endpoint should exist"
}

variable "location" {
  type        = string
  description = "(Required) The supported Azure location where the resource exists"
}

variable "name" {
  type        = string
  description = "(Required) Specifies the Name of the Private Endpoint"
}

variable "subnet_id" {
  type        = string
  description = "(Required) The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint"
}

variable "private_service_connection" {
  type = object({
    name                           = string       #(Required) Specifies the Name of the Private Service Connection
    is_manual_connection           = bool         #(Required) Does the Private Endpoint require Manual Approval from the remote resource owner?
    private_connection_resource_id = string       #(Required) The ID of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to
    subresource_names              = list(string) #(Optional) A list of subresource names which the Private Endpoint is able to connect to
    request_message                = string       #(Optional) A message passed to the owner of the remote resource when the private endpoint attempts to establish the connection to the remote resource. Only valid if is_manual_connection is set to true.
    private_ip_address             = string       #(Computed) The priv/ate IP address associated with the private endpoint, note that you will have a private IP address assigned to the private endpoint even if the connection request was Rejected.
  })
  description = "(Required) TBD"
}


// Optional Variables

variable "private_dns_zone_group" {
  type = object({
    name                 = string       #(Required) Specifies the Name of the Private Service Connection
    private_dns_zone_ids = list(string) #(Required) Specifies the list of Private DNS Zones to include within the private_dns_zone_group
  })
  description = "TBD"
  default = {
    name                 = null
    private_dns_zone_ids = null
  }
}

variable "private_endpoint_prefix" {
  type        = string
  description = "(Required) Prefix for Postgresql server name"
  default     = ""
}

variable "private_endpoint_suffix" {
  type        = string
  description = "(Optional) Suffix for AKS cluster name"
  default     = ""
}

variable "resource_tags" {
  type        = map(string)
  description = "(Optional) Tags for resources"
  default     = {}
}
variable "deployment_tags" {
  type        = map(string)
  description = "(Optional) Tags for deployment"
  default     = {}
}
variable "it_depends_on" {
  type        = any
  description = "(Optional) To define explicit dependencies if required"
  default     = null
}


// Local Values
//**********************************************************************************************
locals {
  timeout_duration      = "1h"
  private_endpoint_name = "${var.private_endpoint_prefix}${var.private_endpoint_suffix}"
}
//**********************************************************************************************