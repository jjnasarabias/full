terraform {
  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = "1.6.4"
    }
  }
}

provider "flux" {
  kubernetes = {
    config_path = module.k3d.kubeconfig_path
  }
  git = {
    url = "ssh://git@github.com/jjnasarabias/full.git"
    branch = "main"
    ssh = {
      username = "git"
      private_key = file("/home/emanuel/.ssh/id_rsa")
    }
  }
}


module "k3d" {
  source = "../../modules/k3d"
  clusterName = "keda"
}


resource "null_resource" "wait_k3d" {
  depends_on = [module.k3d.kubeconfig_path]

  provisioner "local-exec" {
    command = "echo 'K3d cluster is ready'"
  }
}

module "flux" {
  providers = {flux=flux}
  source = "../../modules/flux"
  ssh_key = "/home/emanuel/.ssh/id_rsa"
  kubeconfig = "~/.kube/config"
  bootstrapDir = "flux/clusters/keda"
  depends_on = [null_resource.wait_k3d]
}
