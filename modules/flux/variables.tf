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
}

variable "bootstrapDir" {
  type = string
  description = "The directory to boostrap flux"
}

variable "fluxVersion" {
  description = "The fluxCD version"
  type = string
  default = "2.6.4"
}