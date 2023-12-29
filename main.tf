terraform {
  required_providers {
    spacelift = {
      source = "spacelift-io/spacelift"
      version = "1.8.0"
    }
  }
}

provider "spacelift" {}

resource "spacelift_stack" "portal_codespaces_secrets" {
  name = "${var.user_name}-portal-codespaces-secrets"
  description = "Secrets for ${var.user_name}'s portal codespaces"
  repository = "portal-codespaces" 
  branch = "main"
  space_id = var.space_id
  
}
