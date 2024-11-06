variable "resource_group_name" {
  type        = string
  description = "Resource Group Name."
}

variable "location" {
  type = string
  default = "SouthEast Asia"
}

variable "tags" {
  type = string
}

variable "service_bus_name" {
  type = string
  default = ""
  description = "Service Bus of Azure Function"
}

variable "service_bus_queue_name" {
  type = string
  default = "documents"
  description = "Queue Name of Service Bus using Azure Function"
}

variable "service_bus_sku" {
  type = string
  default = "Standard"
  description = "Service Bus of Azure Function"
}