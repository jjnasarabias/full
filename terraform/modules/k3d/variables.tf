variable "clusterName" {
  type = string
}

variable "servers" {
  type = number
  default = 1
}

variable "agents" {
  type = number
  default = 0
}