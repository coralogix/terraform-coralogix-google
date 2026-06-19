terraform {
  required_version = ">= 0.13.1"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.31.0, < 6.0.0"
    }
  }
}
