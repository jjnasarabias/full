module "flux" {
  source = "../../modules/flux"
  ssh_key = "/home/emanuel/.ssh/id_rsa"
  kubeconfig = "~/.kube/config"
  bootstrapDir = "dev/radius"
}
