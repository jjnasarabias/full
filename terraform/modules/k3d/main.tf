resource "null_resource" "k3d_cluster" {
  triggers = {
    cluster_name = var.clusterName
  }

  provisioner "local-exec" {
    command = <<-EOT
k3d cluster delete ${var.clusterName} 2>/dev/null || true
k3d cluster create ${var.clusterName} --servers ${local.servers} --agents ${local.agents} --wait --timeout 5m
k3d kubeconfig get ${var.clusterName} > ~/.kube/conf.d/${var.clusterName}
EOT
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<-EOT
k3d cluster delete ${self.triggers.cluster_name}
rm ~/.kube/conf.d/${self.triggers.cluster_name}
EOT
  }
}

resource "terraform_data" "cluster_validation" {
  provisioner "local-exec" {
    command = <<-EOT
      kubectl --kubeconfig=${local.kubeconfig} wait --for=condition=Ready nodes --all --timeout=120s
    EOT
  }

  depends_on = [null_resource.k3d_cluster]
}