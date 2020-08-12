resource "google_compute_firewall" "allow_ingress" {
  for_each                = var.allow_ingress
  name                    = each.key
  description             = each.value.description
  direction               = "INGRESS"
  network                 = var.network.self_link
  project                 = var.project.project_id
  source_ranges           = each.value.ranges
  source_tags             = each.value.use_service_accounts ? null : each.value.sources
  source_service_accounts = each.value.use_service_accounts ? each.value.sources : null
  target_tags             = each.value.use_service_accounts ? null : each.value.targets
  target_service_accounts = each.value.use_service_accounts ? each.value.targets : null
  disabled                = lookup(each.value.extra_attributes, "disabled", false)
  priority                = lookup(each.value.extra_attributes, "priority", 1000)
  enable_logging          = lookup(each.value.extra_attributes, "enable_logging", true)
  
  dynamic "allow" {
    for_each = each.value.rules
    iterator = rule
    content {
      protocol = rule.value.protocol
      ports    = rule.value.ports
    }
  }
}

resource "google_compute_firewall" "deny_ingress" {
  for_each                = var.deny_ingress
  name                    = each.key
  description             = each.value.description
  direction               = "INGRESS"
  network                 = var.network.self_link
  project                 = var.project.project_id
  source_ranges           = each.value.ranges 
  source_tags             = each.value.use_service_accounts ? null : each.value.sources
  source_service_accounts = each.value.use_service_accounts ? each.value.sources : null
  target_tags             = each.value.use_service_accounts ? null : each.value.targets
  target_service_accounts = each.value.use_service_accounts ? each.value.targets : null
  disabled                = lookup(each.value.extra_attributes, "disabled", false)
  priority                = lookup(each.value.extra_attributes, "priority", 1000)
  enable_logging          = lookup(each.value.extra_attributes, "enable_logging", true)

  dynamic "deny" {
    for_each = each.value.rules
    iterator = rule
    content {
      protocol = rule.value.protocol
      ports    = rule.value.ports
    }
  }
}

resource "google_compute_firewall" "allow_egress" {
  for_each                = var.allow_egress
  name                    = each.key
  description             = each.value.description
  direction               = "EGRESS"
  network                 = var.network.self_link
  project                 = var.project.project_id
  destination_ranges      = each.value.ranges
  target_tags             = each.value.use_service_accounts ? null : each.value.targets
  target_service_accounts = each.value.use_service_accounts ? each.value.targets : null
  disabled                = lookup(each.value.extra_attributes, "disabled", false)
  priority                = lookup(each.value.extra_attributes, "priority", 1000)
  enable_logging          = lookup(each.value.extra_attributes, "enable_logging", true)
  dynamic "allow" {
    for_each = each.value.rules
    iterator = rule
    content {
      protocol = rule.value.protocol
      ports    = rule.value.ports
    }
  }
}

resource "google_compute_firewall" "deny_egress" {
  for_each                = var.deny_egress
  name                    = each.key
  description             = each.value.description
  direction               = "EGRESS"
  network                 = var.network.self_link
  project                 = var.project.project_id
  destination_ranges      = each.value.ranges
  target_tags             = each.value.use_service_accounts ? null : each.value.targets
  target_service_accounts = each.value.use_service_accounts ? each.value.targets : null
  disabled                = lookup(each.value.extra_attributes, "disabled", false)
  priority                = lookup(each.value.extra_attributes, "priority", 1000)
  enable_logging          = lookup(each.value.extra_attributes, "enable_logging", true)

  dynamic "deny" {
    for_each = each.value.rules
    iterator = rule
    content {
      protocol = rule.value.protocol
      ports    = rule.value.ports
    }
  }
}
