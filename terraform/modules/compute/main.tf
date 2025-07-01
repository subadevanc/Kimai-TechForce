resource "aws_instance" "bastion" {
  ami = "ami-0c55b159cbfafe1f0" # Replace with correct region AMI if needed
  instance_type = "t2.micro"
  subnet_id = var.public_subnet_id
  vpc_security_group_ids = [var.bastion_sg_id]

  tags = {
    Name = "Bastion Host"
  }
}

resource "aws_instance" "jenkins" {
  ami = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id = var.public_subnet_id
  vpc_security_group_ids = [var.jenkins_sg_id]

  tags = {
    Name = "Jenkins Server"
  }
}
