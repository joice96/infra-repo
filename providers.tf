terraform {
  //  required_version = "~> 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

provider "aws" {
  access_key = "AKIAQ2REKBP6JFWS2IVF"
  secret_key = "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"
  region = "us-west-2"
}
