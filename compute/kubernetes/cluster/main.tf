resource "google_container_cluster" "cluster" {
  project        = var.project.project_id
  name           = var.name
  description    = var.description
  location       = var.location
  node_locations = length(var.node_locations) == 0 ? null : var.node_locations
  network        = var.network.self_link
  subnetwork     = var.subnetwork.name

  /*
  min_master_version          = var.min_master_version
  logging_service             = var.logging_service
  monitoring_service          = var.monitoring_service
  resource_labels             = var.labels
  default_max_pods_per_node   = var.default_max_pods_per_node
  enable_binary_authorization = var.enable_binary_authorization
  enable_intranode_visibility = var.enable_intranode_visibility
  enable_shielded_nodes       = var.enable_shielded_nodes
  enable_tpu                  = var.enable_tpu
*/

  remove_default_node_pool = true
  initial_node_count       = var.initial_node_count

  node_config {} // default node_pool removed by default

  addons_config {
    http_load_balancing {
      disabled = ! var.http_load_balancing
    }

    horizontal_pod_autoscaling {
      disabled = ! var.horizontal_pod_autoscaling
    }

    network_policy_config {
      disabled = ! var.network_policy_config
    }
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = var.maintenance_start_time
    }
  }

  /*
  ip_allocation_policy {
    cluster_secondary_range_name  = var.secondary_range_pods
    services_secondary_range_name = var.secondary_range_services
  }
*/
}



/*
resource "google_container_cluster" "cluster" {

  dynamic master_authorized_networks_config {
    for_each = length(var.master_authorized_ranges) == 0 ? [] : list(var.master_authorized_ranges)
    iterator = ranges
    content {
      dynamic cidr_blocks {
        for_each = ranges.value
        iterator = range
        content {
          cidr_block   = range.value
          display_name = range.key
        }
      }
    }
  }

  dynamic network_policy {
    for_each = var.addons.network_policy_config ? [""] : []
    content {
      enabled  = true
      provider = "CALICO"
    }
  }

  dynamic private_cluster_config {
    for_each = local.is_private ? [var.private_cluster_config] : []
    iterator = config
    content {
      enable_private_nodes    = config.value.enable_private_nodes
      enable_private_endpoint = config.value.enable_private_endpoint
      master_ipv4_cidr_block  = config.value.master_ipv4_cidr_block
    }
  }

  # beta features

  dynamic authenticator_groups_config {
    for_each = var.authenticator_security_group == null ? [] : [""]
    content {
      security_group = var.authenticator_security_group
    }
  }

  dynamic cluster_autoscaling {
    for_each = var.cluster_autoscaling.enabled ? [var.cluster_autoscaling] : []
    iterator = config
    content {
      enabled = true
      resource_limits {
        resource_type = "cpu"
        minimum       = config.value.cpu_min
        maximum       = config.value.cpu_max
      }
      resource_limits {
        resource_type = "memory"
        minimum       = config.value.memory_min
        maximum       = config.value.memory_max
      }
      // TODO: support GPUs too
    }
  }

  dynamic database_encryption {
    for_each = var.database_encryption.enabled ? [var.database_encryption] : []
    iterator = config
    content {
      state    = config.value.state
      key_name = config.value.key_name
    }
  }

  dynamic pod_security_policy_config {
    for_each = var.pod_security_policy != null ? [""] : []
    content {
      enabled = var.pod_security_policy
    }
  }

  dynamic release_channel {
    for_each = var.release_channel != null ? [""] : []
    content {
      channel = var.release_channel
    }
  }

  dynamic resource_usage_export_config {
    for_each = (
      var.resource_usage_export_config.enabled != null
      &&
      var.resource_usage_export_config.dataset != null
      ? [""] : []
    )
    content {
      enable_network_egress_metering = var.resource_usage_export_config.enabled
      bigquery_destination {
        dataset_id = var.resource_usage_export_config.dataset
      }
    }
  }

  dynamic vertical_pod_autoscaling {
    for_each = var.vertical_pod_autoscaling == null ? [] : [""]
    content {
      enabled = var.vertical_pod_autoscaling
    }
  }

  dynamic workload_identity_config {
    for_each = var.workload_identity ? [""] : []
    content {
      identity_namespace = "${var.project_id}.svc.id.goog"
    }
  }

}
*/