resource "azurerm_policy_definition" "workload_to_pod_label_mutation" {
  for_each = local.workloadsLabelsMap

  name         = "${local.labelsDomain}_${each.value.label}_${each.value.value}-from-workload-to-pod"
  policy_type  = "Custom"
  mode         = "Microsoft.Kubernetes.Data"
  display_name = "Add workload ${each.value.label} label to pod"
  description  = "Add workload ${local.labelsDomain}/${each.value.label}: ${each.value.value} label to workload pod template spec"

  metadata = jsonencode({
    version  = "1.0.0"
    category = "Kubernetes"
  })

  parameters = jsonencode({
    effect = {
      type = "String"
      metadata = {
        displayName = "Effect"
        description = "Enable or disable the execution of this policy"
      }
      allowedValues = ["Mutate", "Disabled"]
      defaultValue  = "Mutate"
    }
  })

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field = "type",
          equals = "Microsoft.Kubernetes.Data"
        },
        {
          field = "Microsoft.Kubernetes.Data.kind",
          in = ["Deployment", "StatefulSet", "DaemonSet"]
        },
        {
          field = "Microsoft.Kubernetes.Data.metadata.namespace",
          notIn = local.excludedNamespaces
        },
        {
          field = "Microsoft.Kubernetes.Data.spec.template.metadata.labels.${local.labelsDomain}~1${each.value.label}",
          exists = "true"
        },
        {
          field = "Microsoft.Kubernetes.Data.spec.template.metadata.labels.${local.labelsDomain}~1${each.value.label}",
          equals = each.value.value
        }
      ]
    },
    then = {
      effect = "[parameters('effect')]",
      details = {
        operations = [
          {
            operation = "addOrReplace",
            path = "/spec/template/metadata/labels/${local.labelsDomain}~1${each.value.label}",
            value = each.value.value
          }
        ]
      }
    }
  }
  )
}