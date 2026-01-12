variable "project_name" {
    default = "robomart"
}

variable "environment" {
  default  =   "dev"
}

variable "sg_names" {
  default = [
    #database
    "mongodb", "redis", "rabbitmq", "mysql",
    #bastion
    "bastion",
    # Ingress load balancer
    "ingress_alb",
    #VPN
    "openvpn",
    #EKS
    "eks_control_plane",
    "eks_node"
  ]
}