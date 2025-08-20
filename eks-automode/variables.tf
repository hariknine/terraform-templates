# Variables for EKS Cluster and VPC Configuration
variable "vpc_name" {
  type = string
  default = "sample-vpc"
  
}

variable "cluster_name" {
  type = string
  default = "sample-eks-cluster"
}

variable "az" {
  type = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "vpc_cidr" {
  type = string
  default = "10.10.0.0/16"
}

variable "vpc_public_subnets" {
  type = list(string)
  default = ["10.10.101.0/24", "10.10.102.0/24"]
}

variable "vpc_private_subnets" {
  type = list(string)
  default = ["10.10.201.0/24", "10.10.202.0/24"]
}