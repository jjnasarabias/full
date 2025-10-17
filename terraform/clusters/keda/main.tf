terraform {
  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = "1.6.4"
    }
  }
}


module "k3d" {
  source = "../../modules/k3d"
  clusterName = "crds"
}


resource "null_resource" "wait_k3d" {
  depends_on = [module.k3d.kubeconfig_path]

  provisioner "local-exec" {
    command = "K3d cluster is ready"
  }
}

module "flux" {
  source = "../../modules/flux"
  ssh_key = "/home/emanuel/.ssh/id_rsa"
  kubeconfig = "~/.kube/config"
  bootstrapDir = "flux/clusters/keda"
  depends_on = ["null_resource.wait_k3d"]
}
