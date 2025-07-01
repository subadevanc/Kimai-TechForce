output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "jenkins_public_ip" {
  value = aws_instance.jenkins.public_ip
}
