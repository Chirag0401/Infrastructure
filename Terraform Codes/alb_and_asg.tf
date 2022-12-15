module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "8.2.1"
  name               = "chirag-nodejs-alb"
  load_balancer_type = "application"
  vpc_id             = "vpc-0b152e664a9181698"
  subnets            = ["subnet-02d6324db148b6672","subnet-0cd6b5a5e7682017a"]
  security_groups    = [aws_security_group.alb.id]
  target_groups = [
    {
      name             = "chirag-TG"
      backend_protocol = "HTTP"
      backend_port     = 3000
      target_type      = "instance"
      targets          = {}
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/healthz"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "404"
      }
    }
  ]
  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = "arn:aws:acm:us-west-2:421320058418:certificate/73b9c44b-3865-4f0a-b508-dc118857ae2e"
      target_group_index = 0
    }
  ]
  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
  tags = {
    Owner = "chirag"
  }
}
module "asg" {
  source = "terraform-aws-modules/autoscaling/aws"
  # Autoscaling group
  name                      = "chirag-nodejs-asg"
  min_size                  = 1
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = ["subnet-016ccb4320b2a1e12", "subnet-053ad167091ccc461"]
  target_group_arns         = module.alb.target_group_arns
  # Launch template
  launch_template_name        = "chirag-lt"
  launch_template_description = "Launch template for nodejs"
  update_default_version      = true
  image_id                    = "ami-0962359c36baaed1f"
  instance_type               = "t3a.small"
  iam_instance_profile_name   = "chirag-role"
  ebs_optimized               = true
  enable_monitoring           = true
  key_name                    = "Chirag-Nodejs"
  security_groups             = [aws_security_group.node.id]
  tags = {
    Owner = "chirag"
  }
}
resource "aws_security_group" "node" {
  name   = "chirag-asg-sg"
  vpc_id = "vpc-0b152e664a9181698"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name  = "chirag-asg-sg"
    Owner = "chirag"
  }
}
resource "aws_security_group" "alb" {
  name   = "chirag-sg-alb"
  vpc_id = "vpc-0b152e664a9181698"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name  = "chirag-alb-sg"
    Owner = "chirag"
  }
}