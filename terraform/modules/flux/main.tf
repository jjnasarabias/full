terraform {
  required_providers {
    flux = {
      source  = "fluxcd/flux"
    }
  }
}


resource "flux_bootstrap_git" "this" {
  path = var.bootstrapDir
}
