variable "vpc_name" {
  type = string
  default = "sample-managed-vpc"
  
}

variable "cluster_name" {
  type = string
  default = "sample-managed-eks-cluster"
}

variable "az" {
  type = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "vpc_cidr" {
  type = string
  default = "10.100.0.0/16"
}

variable "vpc_public_subnets" {
  type = list(string)
  default = ["10.100.101.0/24", "10.100.102.0/24"]
}

variable "vpc_private_subnets" {
  type = list(string)
  default = ["10.100.201.0/24", "10.100.202.0/24"]
}

variable "helm_release_versions" {
  type = map(string)
  default = {
	karpenter = "1.6.0"
  }
  
}