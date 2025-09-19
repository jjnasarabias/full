variable "workloadLabels" {
  description = "Labels WITHOUT domain to be copied from workloads to pod template spec"
  type = set(object({
    label = string
    value = string
  }))
}

variable "namespaceLabels" {
  description = "Labels WITHOUT domain to be copied from namespaces to pod template spec"
  type = set(object({
    label = string
    value = string
  }))
}

variable "labelsDomain" {
  description = "Label domain"
  type = string
  default = "xpto.org"
}

variable "kubeconfig" {
  description = "Kubeconfig path"
  type = string
  default = "~/.kube/config"
}