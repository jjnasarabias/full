variable "excludedNamespaces" {
  description = "Namespaces to be excluded for policy schedule"
  type = set(string)
  default = [
    "azappconfig-system",
    "cert-manager-system",
    "datadog-system",
    "external-dns-system",
    "external-secrets-system",
    "flux-system",
    "gatekeeper-system",
    "keda-system",
    "kube-system",
    "nginx-system",
    "reflector-system",
    "reloader-system",
    "twistlock-system",
    "upbound-system",
    "vela-system",
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


variable "labelsDomain" {
  description = "Label domain"
  type = string
  default = "xpto.test.com"
}
