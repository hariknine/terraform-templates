terraform {
  backend "gcs" {
    bucket  = "terraform-state-bucket"
    prefix     = "sample-cluster/"
  }
}