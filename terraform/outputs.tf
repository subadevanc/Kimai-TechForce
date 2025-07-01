output "bastion_public_ip" {
  value = module.compute.bastion_public_ip
}

output "jenkins_public_ip" {
  value = module.compute.jenkins_public_ip
}
