resource "google_container_node_pool" "node_pool" {

  project  = var.project.project_id
  name     = var.name
  location = var.location
  cluster  = var.cluster.name
  //node_count = var.node_count

  initial_node_count = var.initial_node_count
  //max_pods_per_node  = var.max_pods_per_node
  node_count     = var.autoscaling_config == null ? var.node_count : null
  node_locations = var.node_locations
  version        = var.gke_version


  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }

  node_config {
    preemptible  = false
    machine_type = var.machine_type
    image_type   = "COS"

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  management {
    auto_repair = true
  }
}

/*
resource "google_container_node_pool" "nodepool" {
  provider = google-beta

  project  = var.project_id
  cluster  = var.cluster_name
  location = var.location
  name     = var.name

  initial_node_count = var.initial_node_count
  max_pods_per_node  = var.max_pods_per_node
  node_count         = var.autoscaling_config == null ? var.node_count : null
  node_locations     = var.node_locations
  version            = var.gke_version

  node_config {
    disk_size_gb     = var.node_config_disk_size
    disk_type        = var.node_config_disk_type
    image_type       = var.node_config_image_type
    labels           = var.node_config_labels
    local_ssd_count  = var.node_config_local_ssd_count
    machine_type     = var.node_config_machine_type
    metadata         = var.node_config_metadata
    min_cpu_platform = var.node_config_min_cpu_platform
    oauth_scopes     = var.node_config_oauth_scopes
    preemptible      = var.node_config_preemptible
    service_account  = var.node_config_service_account
    tags             = var.node_config_tags

    dynamic guest_accelerator {
      for_each = var.node_config_guest_accelerator
      iterator = config
      content {
        type  = config.key
        count = config.value
      }
    }

    dynamic sandbox_config {
      for_each = (
        var.node_config_sandbox_config != null
        ? [var.node_config_sandbox_config]
        : []
      )
      iterator = config
      content {
        sandbox_type = config.value
      }
    }

    dynamic shielded_instance_config {
      for_each = (
        var.node_config_shielded_instance_config != null
        ? [var.node_config_shielded_instance_config]
        : []
      )
      iterator = config
      content {
        enable_secure_boot          = config.value.enable_secure_boot
        enable_integrity_monitoring = config.value.enable_integrity_monitoring
      }
    }

    workload_metadata_config {
      node_metadata = var.workload_metadata_config
    }

  }

  dynamic autoscaling {
    for_each = var.autoscaling_config != null ? [var.autoscaling_config] : []
    iterator = config
    content {
      min_node_count = config.value.min_node_count
      max_node_count = config.value.max_node_count
    }
  }

  dynamic management {
    for_each = var.management_config != null ? [var.management_config] : []
    iterator = config
    content {
      auto_repair  = config.value.auto_repair
      auto_upgrade = config.value.auto_upgrade
    }
  }

  dynamic upgrade_settings {
    for_each = var.upgrade_config != null ? [var.upgrade_config] : []
    iterator = config
    content {
      max_surge       = config.value.max_surge
      max_unavailable = config.value.max_unavailable
    }
  }
}
*/
