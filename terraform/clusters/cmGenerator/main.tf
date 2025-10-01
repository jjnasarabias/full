terraform {
  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = "1.6.4"
    }
  }
}

module "flux" {
  source = "../../modules/flux"
  ssh_key = "/home/emanuel/.ssh/id_rsa"
  kubeconfig = "~/.kube/config"
  bootstrapDir = "flux/clusters/cmGenerator"
}
