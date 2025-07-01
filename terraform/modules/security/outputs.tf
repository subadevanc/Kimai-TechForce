output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}

output "jenkins_sg_id" {
  value = aws_security_group.jenkins_sg.id
}
