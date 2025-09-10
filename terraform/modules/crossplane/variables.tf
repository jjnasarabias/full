variable "crossplane" {
  description = "Helm app configuration"
  type = object({
    name = string
    chart = string
    version = string
    repository = string
    namespace = string
    values = map(any)
  })
  default = {
    name       = "crossplane"
    chart      = "crossplane"
    version    = "2.0.2-up.3"
    repository = "https://charts.upbound.io/stable"
    namespace  = "crossplane-system"
    values = {}
  }
}

variable "kubeconfig" {
  description = "Kubeconfig path"
  type = string
  default = "~/.kube/conf.d/dev"
}