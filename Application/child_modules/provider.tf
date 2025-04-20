terraform {
    required_providers {
      google-beta = {
        source = "hashicorp/google-beta"
        version = "6.30.0"
      }

      google = {
        source = "hashicorp/google"
        version = "6.30.0"
      }
    }
}

provider "google-beta" {
  project = var.project
}

provider "google" {
    project = var.project  
}