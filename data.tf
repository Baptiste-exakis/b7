resource "azurerm_ssh_public_key" "ssh_key" {
  name                = "ssh_key_admin"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  public_key          = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCTwIU18gQQbE9Inblg52+IEwSXb84RgFoVbR5Sm3y25JfI/fFdP7ylHeu2tJadVEqvOdK6PaHMeJqNd+adDpHXPnhVYoNhO8qxh/z+CblyZk7Gleztk11YtzCTx62LDCk5O4PI+qOC8sOT7gADt9zJk21jjqITH4dlaWBQNS01ve2mOuOLjmUSe1T4ndK6OXHeObIiC8PNEnnBcMwUqzfnZWTY5WOBibkJx8/vMH4SV00IdGVooPneyn6yD2YgoigGEUMr1Deb1+sAxxXt/xTfuQIRCcZ+AWI0Q1zlF5UwgIPnul03YBcEMygdU/9Y0cWqFW/Nug1S4uCRI2ld5wd9 rsa-key-20230201"
}

resource "random_string" "password" {
  length = 16
  special = true
  override_special = "/@\" "
}
