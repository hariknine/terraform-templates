module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.az
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = true

  public_subnet_tags = {
    Type                                        = "public"
    SubnetType                                  = "Utility"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }

  private_subnet_tags = {
    Type                                        = "private"
    SubnetType                                  = "Private"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
    "karpenter.sh/discovery"                    = "${var.cluster_name}"
    "kubernetes.io/role/cni"                    = "1"
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
