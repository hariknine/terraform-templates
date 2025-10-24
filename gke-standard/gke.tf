module "gke" {
  source                   = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id               = var.project_id
  name                     = var.cluster_name
  release_channel          = "REGULAR"
  kubernetes_version       = "1.33"
  region                   = var.region
  zones                    = var.zones
  network                  = var.network_name
  subnetwork               = var.subnet_01_name
  ip_range_pods            = ""
  ip_range_services        = ""
  http_load_balancing      = true
  logging_service          = "none"
  remove_default_node_pool = true
  deletion_protection      = false
  enable_private_nodes = false
  # DRA
  #enable_k8s_beta_apis = ["resource.k8s.io/v1beta1/deviceclasses","resource.k8s.io/v1beta1/resourceclaims","resource.k8s.io/v1beta1/resourceclaimtemplates","resource.k8s.io/v1beta1/resourceslices"]

  node_pools = [
    {
      name               = "primary-pool"
      machine_type       = "e2-standard-2"
      node_locations     = "us-central1-a"
      autoscaling        = true
      initial_node_count = 1
      min_count          = 1
      max_count          = 10
      autoscaling        = true
      local_ssd_count    = 0
      spot               = false
      disk_size_gb       = 100
      disk_type          = "pd-standard"
      image_type         = "COS_CONTAINERD"
      auto_repair        = true
      auto_upgrade       = true
    },
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  node_pools_labels = {
    all = {}

    default-pool = {
      default-pool = true
    }

    gpu-pool = {
      "gke-no-default-nvidia-gpu-device-plugin" = "true"
    }
  }

  node_pools_taints = {
    all = []
  }

  node_pools_tags = {
    all = []

    default-pool = [
      "default-pool",
    ]
  }
}
