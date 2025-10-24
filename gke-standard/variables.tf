variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default = "sample-project"
  
}
variable "network_name" {
  type = string
  default = "sample-vpc"
  
}

variable "cluster_name" {
  type = string
  default = "sample-cluster"
}

variable "account_id" {
  type = string
  default = "sample-service-account"
}
variable "region" {
  type = string
  default = "us-central1"
}

variable "zones" {
  type = list(string)
  default = ["us-central1-a", "us-central1-b", "us-central1-f"]
  
}

variable "subnet_01_ip" {
  type = string
  default = "10.100.0.0/24"
}

variable "subnet_01_name" {
  type = string
  default = "sample-vpc-subnet-01"
}

variable "ip_range_pods" {
  type = string
  default = "sample-vpc-pods"
}

variable "ip_range_services" {
  type = string
  default = "sample-vpc-services"
  
}