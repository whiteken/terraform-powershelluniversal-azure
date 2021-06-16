terraform {
  backend "remote" {
    organization = "Auto_Cloud"

    workspaces {
      name = "azure-powershelluniversal-webapp"
    }
  }
}