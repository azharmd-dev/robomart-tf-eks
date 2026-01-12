output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet" {
  value = module.vpc.public_subnet
}

output "private_subnet" {
  value = module.vpc.private_subnet
}

output "database_subnet" {
  value = module.vpc.database_subnet
}

output "ig_gw" {
  value = module.vpc.ig_gw
}

output "eip" {
  value = module.vpc.elastic_ip
}