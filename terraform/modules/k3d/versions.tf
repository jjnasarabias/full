terraform {
  required_version = ">= 1.0"

  required_providers {
    k3d = {
      source  = "nikhilsbhat/k3d"
      version = "0.0.2"
    }
  }
}