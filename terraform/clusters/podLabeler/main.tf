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
  source = "../../modules/gatekeeper"
  namespaceLabels = [
    {"label": "test", "value": "test"},
    {"label": "test2", "value": "test2"}
  ]
  workloadLabels = [
    {"label": "namespace-test", "value": "namespace-test"},
    {"label": "namespace-test2", "value": "namespace-test2"}
  ]
}