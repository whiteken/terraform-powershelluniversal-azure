
output "ftp_username" {
  value = azurerm_app_service.webapp.site_credential.username
}

output "ftp_password" {
  value = azurerm_app_service.webapp.site_credential.password
}