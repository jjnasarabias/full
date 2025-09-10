terraform {
  required_providers {
    flux = {
      source  = "fluxcd/flux"
    }
  }
}

provider "flux" {
  kubernetes = {
    config_path = var.kubeconfig
  }
  git = {
    url = var.flux_repo
    branch = "main"
    ssh = {
      username = "git"
      private_key = file(var.ssh_key)
    }
  }
}

resource "flux_bootstrap_git" "this" {
  path = var.bootstrapDir
}
