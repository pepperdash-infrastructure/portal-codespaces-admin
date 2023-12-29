terraform {
  required_providers {
    spacelift = {
      source = "spacelift-io/spacelift"
      version = "1.8.0"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.31.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "spacelift" {}

data "aws_caller_identity" "current" {}

locals {
  role_name = "spacelift-${var.user_name}"
  role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${local.role_name}"
}

resource "spacelift_stack" "portal_codespaces_secrets" {
  name = "${var.user_name}-portal-codespaces-secrets"
  description = "Secrets for ${var.user_name}'s portal codespaces"
  repository = "pepperdash-infrastructure/portal-codespaces" 
  branch = "main"
}

resource "spacelift_aws_integration" "aws_integration" {
  name = local.role_name
  role_arn = local.role_arn
  generate_credentials_in_worker = true
}

