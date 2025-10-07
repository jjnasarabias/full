locals {
  kubeconfig = var.kubeconfig
  namespaceLabelsMap = {
    for item in var.namespaceLabels : "${item.label}-${item.value}" => item
  }
  labelsDomain = var.labelsDomain
  excludedNamespaces = var.excludedNamespaces
}
