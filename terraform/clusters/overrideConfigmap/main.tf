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
  clusterName = "kustom"
}


module "flux" {
  source = "../../modules/flux"
  kubeconfig = module.k3d.kubeconfig_path
  bootstrapDir = "flux/clusters/${module.k3d.cluster_name}"
}
