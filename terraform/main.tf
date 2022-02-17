terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.96.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "abhi-brady-rg"
    storage_account_name = "abhibradystorage"
    container_name       = "abhibradycontainer"
    key                  = "prod.terraform.tfstate"
  }
}

#configure the Azure provider.
provider "azurerm" {
  features {
      key_vault {
        purge_soft_delete_on_destroy = true
      }
  }
}

data "azurerm_client_config" "current" {}

#create azure resource group for the weather app.
resource "azurerm_resource_group" "abhi-weatherapp-rg" {
  name     = "abhi-weatherapp-rg"
  location = "uksouth"
}

resource "azurerm_app_service_plan" "abhi-brady-svcplan" {
    name                = "weatherapp-svcplan"
    location            = azurerm_resource_group.abhi-weatherapp-rg.location
    resource_group_name = azurerm_resource_group.abhi-weatherapp-rg.name
    sku {
        tier = "Free"
        size = "F1"
    }
}

resource "azurerm_app_service" "abhi-brady-appsvc" {
  name                = "weatherapp-appsvc"
  location            = azurerm_resource_group.abhi-weatherapp-rg.location
  resource_group_name = azurerm_resource_group.abhi-weatherapp-rg.name
  app_service_plan_id = azurerm_app_service_plan.abhi-brady-svcplan.id
  source_control {
    repo_url           = "https://github.com/abhixcode/devops-interview"
    branch             = "main"
    manual_integration = true
    use_mercurial = false
  }
}