locals {
  kubeconfig = var.kubeconfig
  namespaceLabelsMap = {
    for item in var.namespaceLabels : "${item.label}-${item.value}" => item
  }
  workloadsLabelsMap = {
    for item in var.workloadLabels : "${item.label}-${item.value}" => item
  }
  labelsDomain = var.labelsDomain
  excludedNamespaces = var.excludedNamespaces
}
