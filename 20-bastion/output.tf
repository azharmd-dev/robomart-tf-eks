output "ami_id" {
  value = data.aws_ami.devops_practice.id
}

output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}