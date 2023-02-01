resource "azurerm_kubernetes_cluster" "k8s" {
  name                = var.cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.agent_count
    vm_size    = "Standard_D2_v2"
  }
  linux_profile {
    admin_username = "Baptiste"
    ssh_key {
      key_data = azurerm_ssh_public_key.ssh_key.public_key
    }
  }
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_storage_account" "redis" {
  name                     = "redisk8sstockage"
  resource_group_name      = azurerm_kubernetes_cluster.k8s.node_resource_group
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "redis" {
  name                 = "redisk8spartage"
  storage_account_name = azurerm_storage_account.redis.name
  quota                = 50

  acl {
    id = "MTIzNDU2Nzg5MDEyMzQ1Njc4OTAxMjM0NTY3ODkwMTI"

    access_policy {
      permissions = "rwdl"
      start       = "2019-07-02T09:38:21.0000000Z"
      expiry      = "2019-07-02T10:38:21.0000000Z"
    }
  }
}
resource "null_resource" "akscredentials" {
  provisioner "local-exec" {
    command = "az aks get-credentials --resource-group ${azurerm_resource_group.rg.name} --name ${azurerm_kubernetes_cluster.k8s.name}"
  }
  depends_on = [azurerm_kubernetes_cluster.k8s]
}

resource "null_resource" "storagesecret" {
  provisioner "local-exec" {
    command = "kubectl create secret generic azure-secret --from-literal=azurestorageaccountname=${azurerm_storage_account.redis.name} --from-literal=azurestorageaccountkey=${azurerm_storage_account.redis.primary_access_key}"
  }
}

