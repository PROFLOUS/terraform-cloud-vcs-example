terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

variable "production" {
  description = "Is this a production environment?"
  type        = string
  default = "green"
}

module "base" {
  source     = "terraform-in-action/aws/bluegreen//modules/base"
  production = var.production
}

module "green" {
  source      = "terraform-in-action/aws/bluegreen//modules/autoscaling"
  app_version = "v1.0"
  label       = "green"
  base        = module.base
}

output "lb_dns_name" {
  value = module.base.lb_dns_name
}