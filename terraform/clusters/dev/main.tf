# module "aws" {
#   source = "../.."
#   aws = merge(
#     var.aws,
#     {
#       endpoint = aws_endpoint
#     }
#   )
# }

module "crossplane" {
  source = "../../modules/crossplane"
}

module "flux" {
  source = "../../modules/flux"
  ssh_key = "~/.ssh/id_rsa"
  bootstrapDir = "flux/clusters/dev"
}

