# Lock in the specify the provider version
terraform {

  #version of the terraform executable
  required_version = ">= 1.0.0"

  #version of the azurerm provider
  required_providers {
    azurerm = {
      version = ">= 2.63.0"
      source  = "hashicorp/azurerm"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}