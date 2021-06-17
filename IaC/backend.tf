terraform {
  backend "remote" {
    organization = "Auto_Cloud"

    workspaces {
      name = "powershelluniversal-webapp-azure"
    }
  }
}