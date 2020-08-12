locals {
  subnets = {
    for subnet in var.subnets :
    "${subnet.region}/${subnet.name}" => subnet
  }
}

resource "google_compute_subnetwork" "subnet" {
	for_each                 = local.subnets
	project                  = var.project.project_id
	network                  = var.network.self_link

	name                     = each.value.name
	ip_cidr_range            = each.value.ip_range
	region                   = each.value.region   // make this default to a network region?
  private_ip_google_access = lookup( each.value, "subnet_private_access", true )
	description              = lookup( each.value, "description", null )
	dynamic "log_config" {
    for_each = lookup(each.value, "subnet_flow_logs", true) ? [{
      aggregation_interval = lookup(each.value, "subnet_flow_logs_interval", "INTERVAL_5_SEC")
      flow_sampling        = lookup(each.value, "subnet_flow_logs_sampling", "0.5")
      metadata             = lookup(each.value, "subnet_flow_logs_metadata", "INCLUDE_ALL_METADATA")
    }] : []
    content {
      aggregation_interval = log_config.value.aggregation_interval
      flow_sampling        = log_config.value.flow_sampling
      metadata             = log_config.value.metadata
    }
  }

	//secondary ip ranges
}
