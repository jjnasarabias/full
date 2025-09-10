provider "helm" {
  kubernetes = {
    config_path = var.kubeconfig
  }
}


resource "helm_release" "crossplane" {
  name       = var.crossplane.name
  chart      = var.crossplane.chart
  repository = var.crossplane.repository
  namespace  = var.crossplane.namespace
  version    = var.crossplane.version
  create_namespace = true
  values = [
    yamlencode(var.crossplane.values)
  ]

}