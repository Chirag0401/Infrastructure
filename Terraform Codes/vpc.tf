module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "Chirag-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets = ["10.0.6.0/24", "10.0.7.0/24"]
  public_subnets  = ["10.0.104.0/24", "10.0.105.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true
  single_nat_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}