output "cluster_name" {
  value      = var.clusterName
  depends_on = [null_resource.k3d_cluster]
}

output "kubeconfig_path" {
  value      = pathexpand("~/.kube/conf.d/${var.clusterName}")
  depends_on = [terraform_data.cluster_validation]
}