output "kubeconfig_path" {
  # value = pathexpand("~/.kube/conf.d/${var.clusterName}")
  value = pathexpand("${var.kubeconfig}")
}