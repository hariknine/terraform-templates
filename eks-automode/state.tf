terraform {
  backend "s3" {
    bucket  = "terraform-state-aws-us-east-1"
    key     = "sample-eks-cluster/terraform.tfstate"
    region  = "us-east-1"
    profile = "sample-aws-profile"
  }
}
