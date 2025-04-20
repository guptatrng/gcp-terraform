terraform {
    required_providers {
      google = {
        source = "hashicorp/google"
        version = "6.30.0"
      }
      google-beta = {
        source = "hashicorp/google-beta"
        version = "6.30.0"
      }
    }

    backend "gcs" {}
}

provider "google" {
  project = var.project
}

provider "google-beta" {
  project = var.project
}