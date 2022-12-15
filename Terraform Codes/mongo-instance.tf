module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = toset(["one-chirag", "two-chirag", "three-chirag"])

  name = "instance-${each.key}"

  ami                    = "ami-0d31d7c9fc9503726"
  instance_type          = "t3a.small"
  key_name               = "chirag-mongo-kp"
  monitoring             = true
  vpc_security_group_ids = ["sg-062436fd12a2f75ba"]
  subnet_id              = "subnet-053ad167091ccc461"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}