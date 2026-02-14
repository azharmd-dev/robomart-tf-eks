variable "ecr_repositories" {
  default = [
    "catalogue",
    "cart",
    "user",
    "shipping",
    "payment",
    "frontend"
  ]
}

variable "project_name" {
    default = "robomart"
}