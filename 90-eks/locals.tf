# locals {
#   common_name_suffix="${var.project_name}-${var.environment}"
#   vpc_id =  data.aws_ssm_parameter.vpc_id.value
#   eks_control_plane_sg_id= data.aws_ssm_parameter.eks_control_plane_sg_id.value
#   eks_node_sg_id=data.aws_ssm_parameter.eks_node_sg_id.value
#   private_subnet_id = split(",", data.aws_ssm_parameter.private_subnet_id.value)
#    common_tags = {
#     Project = var.project_name
#     Environment = var.environment
#     Terraform = "true"
#    }
# }

###222##
locals {
  common_name_suffix = "${var.project_name}-${var.environment}"
  vpc_id                  = data.aws_ssm_parameter.vpc_id.value
  eks_control_plane_sg_id = data.aws_ssm_parameter.eks_control_plane_sg_id.value
  eks_node_sg_id          = data.aws_ssm_parameter.eks_node_sg_id.value
  private_subnet_id       = split(",", data.aws_ssm_parameter.private_subnet_id.value)

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    Terraform   = "true"
  }

  # 🔵 Blue nodegroup (conditional)
  blue_nodegroup = var.enable_blue ? {
    Blue = {
      capacity_type = "SPOT"
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.small","t3.micro"]

      iam_role_additional_policies = {
        amazonEFS = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
        amazonEBS = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }

      min_size     = 3
      max_size     = 10
      desired_size = 3
    }
  } : {}

  # 🟢 Green nodegroup (conditional)
  green_nodegroup = var.enable_green ? {
    Green = {
      capacity_type = "SPOT"
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.small","t3.medium","c5.large"]

      iam_role_additional_policies = {
        amazonEFS = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
        amazonEBS = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }

      min_size     = 3
      max_size     = 10
      desired_size = 3

      taints = {
        upgrade = {
          key    = "upgrade"
          value  = "true"
          effect = "NO_SCHEDULE"
        }
      }
    }
  } : {}

  # Final map used by module
  eks_nodegroups = merge(
    local.blue_nodegroup,
    local.green_nodegroup
  )
}
