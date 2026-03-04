terraform {
  backend "s3" {}
}

provider "aws" {
  region = var.region
}

module "iam" {
  source      = "../../modules/iam"
  environment = var.environment
}

module "vpc" {
  source = "../../modules/vpc"
  name   = "${var.environment}-vpc"

  vpc_cidr        = "10.2.0.0/16"
  public_subnets  = ["10.2.1.0/24", "10.2.2.0/24"]
  private_subnets = ["10.2.3.0/24", "10.2.4.0/24"]
}

module "ecr" {
  source      = "../../modules/ecr"
  environment = var.environment
}

module "rds" {
  source          = "../../modules/rds"
  environment     = var.environment
  private_subnets = module.vpc.private_subnets
  instance_class  = "db.t3.micro"
  username        = var.db_user
  password        = var.db_pass
}

module "eks" {
  source = "../../modules/eks"

  environment      = var.environment
  private_subnets  = module.vpc.private_subnets
  cluster_role_arn = module.iam.cluster_role_arn
  node_role_arn    = module.iam.node_role_arn

  desired_size = 1
  min_size     = 1
  max_size     = 2
}
