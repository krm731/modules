################################################################
# FileName       :     main.tf                                 #
# Author         :     Arun Kumar Lakshmi Narayanan            #
# Description    :     Create private kubernetes cluster       #
################################################################

################################################################
# Create private kubernetes cluster                            # 
################################################################
resource "google_container_cluster" "cluster" {
	project                     = var.project.project_id
  name                        = var.name
	description                 = var.description
  location                    = var.location
  node_locations           		= length(var.node_locations) == 0 ? null : var.node_locations
  network                  		= var.network.self_link
  subnetwork               		= var.subnetwork.name

	remove_default_node_pool = true
  initial_node_count       = var.initial_node_count
  
  # network traffic permission. Remove IP range block and provide Ingress resource here. 
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "${var.master_ipv4_cidr_block}"
      display_name = "testing"
    }
  }

  resource_labels = {"env" = "${var.environment}"}

  # ip_allocation_policy.use_ip_aliases defaults to true, since we define the block `ip_allocation_policy`
  ip_allocation_policy {
    // Choose the range, but let GCP pick the IPs within the range. This needs to be handled by domain. Hardcoding done for example
    cluster_ipv4_cidr_block  = "/16"
    services_ipv4_cidr_block = "/22"
  }

  # This setting will make the cluster private
  # We can optionally control access to the cluster
  # See https://cloud.google.com/kubernetes-engine/docs/how-to/private-clusters
  private_cluster_config {
    enable_private_endpoint = "${var.isprivatecluster ? true : false }"
    enable_private_nodes    = "${var.isprivatecluster ? true : false }"
    master_ipv4_cidr_block  = "${var.isprivatecluster ? var.master_ipv4_cidr_block : null }"
  }

  # This setting will configure network policy. since the source is not configured commented for now
  network_policy {
    enabled  = var.network_policy
    provider = var.network_policy_provider
  }

  node_config {} // default node_pool removed by default

  addons_config {
		http_load_balancing {
      disabled = !var.http_load_balancing
    }

    horizontal_pod_autoscaling {
      disabled = !var.horizontal_pod_autoscaling
    }

    network_policy_config {
      disabled = !var.network_policy_config
    }
  }

  master_auth {
   client_certificate_config {
      issue_client_certificate = true
    }
  }

  maintenance_policy {
		daily_maintenance_window {
			start_time = var.maintenance_start_time
		}
	}
}