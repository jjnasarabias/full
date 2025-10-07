variable "workloadLabels" {
  description = "Labels WITHOUT domain to be copied from workloads to pod template spec"
  type = set(object({
    label = string
    value = string
  }))
  default = []
}

variable "namespaceLabels" {
  description = "Labels WITHOUT domain to be copied from namespaces to pod template spec"
  type = set(object({
    label = string
    value = string
  }))
  default = []
}

variable "excludedNamespaces" {
  description = "Namespaces excluded"
  type = set(string)
  default = [
    "kube-system",
    "flux-system"
  ]
}

variable "labelsDomain" {
  description = "Label domain"
  type = string
  default = "xpto.test.com"
}

variable "kubeconfig" {
  description = "Kubeconfig path"
  type = string
  default = "~/.kube/config"
}