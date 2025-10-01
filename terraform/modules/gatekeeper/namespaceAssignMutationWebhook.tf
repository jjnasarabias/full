resource "kubernetes_manifest" "gatekeeper_namespace_assign" {
  for_each = local.namespaceLabelsMap

  manifest = {
    apiVersion = "mutations.gatekeeper.sh/v1"
    kind       = "Assign"

    metadata = {
      name      = "namespace-to-pod-template-${each.value.label}"
    }

    spec = {
      applyTo = [
        {
          groups   = ["apps"]
          versions = ["v1"]
          kinds    = ["Deployment", "StatefulSet", "DaemonSet"]
        }
      ]

      match = {
        scope = "Namespaced"
        namespaceSelector = {
          matchLabels = {
            "${local.labelsDomain}/${each.value.label}" = each.value.value
          }
        }
      }

      location = "spec.template.metadata.labels.\"${local.labelsDomain}/${each.value.label}\""

      parameters = {
        assign = {
          value = each.value.value
        }
      }
    }
  }
}