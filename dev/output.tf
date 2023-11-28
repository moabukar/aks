output "kubeconfig" {
  value = azurerm_kubernetes_cluster.clusterdev.kube_config_raw
}

resource "local_file" "kubeconfig" {
   content  = "${azurerm_kubernetes_cluster.clusterdev.kube_config_raw}"
   filename = "kubeconfig"
}