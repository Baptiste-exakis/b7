resource "azurerm_ssh_public_key" "ssh_key" {
  name                = "ssh_key_admin"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  public_key          = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCaqpMuafcvfYNbKcGfSa9OGmnhfr3vV0irdGNDlTVV4EBrI0QxkEscOqSZclpbO+DXmx77gSqU/b/vVuM1t9z/mXTKOj7ftm3Au1M0JDXtV82yxb44r0DAwCk7/JsKe5fQpfgV1iCyfMi1qFSR+x1JZZ/mlf61NhYZ8b4SYE+SEeYVl3F90/01bFfA7tzzRtBMKr38SKQcP6HnPTvUzRxBtoV4ZPNRh7c+k9aO2a7A3kxkc36r7gcptji/TIUBGjR2VsNSQ4tULo8WPBBhwSBVjFDEpDe90+J6i2O4STPJBCaYX+MJvLxNyBdFdL4xJBQSqohNmS+Lw3ZerqDJt+SH rsa-key-20230201"
}

resource "random_string" "password" {
  length = 16
  special = true
  override_special = "/@\" "
}
