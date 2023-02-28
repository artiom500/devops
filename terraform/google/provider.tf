provider "google" {
  credentials = var.google_credentials
  project     = var.google_project
  region      = var.google_region
}

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}
