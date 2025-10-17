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
  bootstrapDir = "flux/clusters/podLabeler"
}


module "gatekeeper_mutation_webhooks" {
  kubeconfig = module.flux.kubeconfig_path
  source = "../../modules/gatekeeper"
  namespaceLabels = [
    {"label": "namespace-test", "value": "namespace-test"},
    {"label": "namespace-test2", "value": "namespace-test2"}
  ]
  # depends_on = [module.flux]
}