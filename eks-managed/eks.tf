module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = var.cluster_name
  kubernetes_version = "1.34"

  # Optional
  endpoint_public_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  iam_role_name            = "${var.cluster_name}-eks-role"
  iam_role_use_name_prefix = false # Name was too long using default method

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  security_group_name = "${var.cluster_name}-sg"

  addons = {
    vpc-cni = {
      most_recent    = true
      before_compute = true
    }                                   # AWS VPC CNI
    kube-proxy = { most_recent = true } # kube-proxy on EC2 nodes
    coredns    = { most_recent = true }
    aws-ebs-csi-driver = {
      most_recent              = true
      service_account_role_arn = module.ebs_csi_driver_irsa.arn
    }
  }
  # EKS Managed Node Group(s)
  eks_managed_node_groups = {
    default = {
      name           = "default"
      instance_types = ["t4g.small", "t4g.medium", "t4g.large", "t4g.xlarge"] # Cheaper default instance
      min_size       = 0
      max_size       = 5
      desired_size   = 1
      #capacity_type  = "SPOT"
      ami_type = "AL2023_ARM_64_STANDARD"
    }
    gpu-pool = {
      name           = "gpu-pool"
      instance_types = ["g5.xlarge"]
      min_size       = 0
      max_size       = 1
      desired_size   = 1
      #capacity_type  = "SPOT"
      ami_type = "AL2023_x86_64_NVIDIA" # For built-in drivers
      taints = {
        gpu = {
          key    = "nvidia.com/gpu"
          value  = "true"
          effect = "NO_SCHEDULE"
        }
      }
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
