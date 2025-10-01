variable "excludedNamespaces" {
  description = "Namespaces to be excluded for policy schedule"
  type = set(string)
  default = [
    "kube-system",
    "kube-public",
    "kube-node-lease",
    "gatekeeper-system",
    "flux-system"
  ]
}


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