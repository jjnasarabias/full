variable "kubeconfig" {
  description = "Kubeconfig path"
  type = string
  default = "~/.kube/conf.d/dev"
}

variable "flux_repo" {
  type = string
  description = "Flux repository"
  default = "ssh://git@github.com/jjnasarabias/full.git"
}

variable "ssh_key" {
  type = string
  default = "/home/emanuel/.ssh/id_rsa"
}

variable "bootstrapDir" {
  type = string
  description = "The directory to boostrap flux"
}
