provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket         = "my-terraform-bucket-012"
    key            = "terraform/state"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
  }
}

module "network" {
  source = "./modules/network"
  vpc_cidr = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24"]
  private_subnet_cidrs = ["10.0.2.0/24"]
}

module "security" {
  source = "./modules/security"
  vpc_id = module.network.vpc_id
}

module "compute" {
  source = "./modules/compute"
  vpc_id = module.network.vpc_id
  public_subnet_id = module.network.public_subnet_ids[0]
  private_subnet_id = module.network.private_subnet_ids[0]
  bastion_sg_id = module.security.bastion_sg_id
  jenkins_sg_id = module.security.jenkins_sg_id
}
