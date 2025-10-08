data "k3d_kubeconfig" "k3s-default" {
  clusters = [local.clusterName]
  //  not_encoded = true
  all = false
}