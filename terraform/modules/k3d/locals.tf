locals {
  clusterName = var.clusterName
  servers = var.servers
  agents = var.agents
  kubeconfig = "~/.kube/conf.d/${var.clusterName}"
}