terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
provider "aws" {
  region = "eu-central-1"
  access_key = "AKIA4ECD6FXWWRIQXIVI"
  secret_key = "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"
}
