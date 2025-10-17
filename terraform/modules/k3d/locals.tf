locals {
  clusterName = var.clusterName
  servers = var.servers
  agents = var.agents
  kubeconfig = "$HOME/.kube/conf.d/${var.clusterName}"
}