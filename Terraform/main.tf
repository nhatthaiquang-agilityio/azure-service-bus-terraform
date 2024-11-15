terraform {
  required_providers {

    azurerm = {
      version = ">= 3.0, < 4.0"
      source = "hashicorp/azurerm"
    }

  }

  backend "azurerm" {

  }
}

provider "azurerm" {
  features {}
}

# Create service bus instance
resource "azurerm_servicebus_namespace" "svc_bus" {
  name                			= "${var.service_bus_name}"
  location            			= "${var.location}"
  resource_group_name 			= "${var.resource_group_name}"
  sku                 			= "${var.service_bus_sku}"
  minimum_tls_version 			= 1.2
  capacity 						= 0
  premium_messaging_partitions 	= 0
  local_auth_enabled			= true
  public_network_access_enabled = true
  tags     			  			= var.tags
}

# Create queue
resource "azurerm_servicebus_queue" "svc_bus_queue" {
  name         = "${var.service_bus_queue_name}"
  namespace_id = azurerm_servicebus_namespace.svc_bus.id
  enable_partitioning = true
}

# Create rule
resource "azurerm_servicebus_queue_authorization_rule" "queue_authorization_rule" {
  name     = "queue-rule"
  queue_id = azurerm_servicebus_queue.svc_bus_queue.id

  listen = true
  send   = true
  manage = false
}

output "bus_namespaces_details" {
  value = {
    id   = azurerm_servicebus_namespace.svc_bus.id
    name = azurerm_servicebus_namespace.svc_bus.name
  }
  description = "A map of the created Service Bus Namespace objects, providing each namespace's ID and name."
}
