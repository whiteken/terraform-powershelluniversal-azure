
output "ftp_credential" {
  value = azurerm_app_service.webapp.site_credential
}

output "ftp_url" {
  #TODO: Get the property for the ftp upload url
  value = azurerm_app_service.webapp
}