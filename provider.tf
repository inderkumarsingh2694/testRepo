
terraform {
 cloud {
   organization = "inder-prod"
   workspaces {
     name = "testRepo"
   }
 }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.13.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "edfa60b6-4758-41df-a6d7-11958cda694a"
  tenant_id       = "e4b65f42-9477-42da-b4d1-c669822da2d3"
  client_id       = "9e2dc6c0-1c95-4dde-b5ec-f32aad320097"
  client_secret   = "mcn8Q~RnXM3vjLDJgwgyOIv1BMSBgFpqtgf0AcQf"
  features {

  }
}