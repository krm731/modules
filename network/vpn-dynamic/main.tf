locals {
  gateway_address = (
    var.gateway_address_create
    ? google_compute_address.gateway[0].address
    : var.gateway_address
  )
  router = (
    var.router_create
    ? google_compute_router.router[0].name
    : var.router_name
  )
  secret = random_id.secret.b64_url
}

resource "google_compute_address" "gateway" {
  count   = var.gateway_address_create ? 1 : 0
  name    = "vpn-${var.name}"
  project = var.project.project_id
  region  = var.region
}

resource "google_compute_forwarding_rule" "esp" {
  name        = "vpn-${var.name}-esp"
  project     = var.project.project_id
  region      = var.region
  target      = google_compute_vpn_gateway.gateway.self_link
  ip_address  = local.gateway_address
  ip_protocol = "ESP"
}

resource "google_compute_forwarding_rule" "udp-500" {
  name        = "vpn-${var.name}-udp-500"
  project     = var.project.project_id
  region      = var.region
  target      = google_compute_vpn_gateway.gateway.self_link
  ip_address  = local.gateway_address
  ip_protocol = "UDP"
  port_range  = "500"
}

resource "google_compute_forwarding_rule" "udp-4500" {
  name        = "vpn-${var.name}-udp-4500"
  project     = var.project.project_id
  region      = var.region
  target      = google_compute_vpn_gateway.gateway.self_link
  ip_address  = local.gateway_address
  ip_protocol = "UDP"
  port_range  = "4500"
}

resource "google_compute_router" "router" {
  count   = var.router_create ? 1 : 0
  name    = var.router_name == "" ? "vpn-${var.name}" : var.router_name
  project = var.project.project_id
  region  = var.region
  network = var.network.self_link
  bgp {
    advertise_mode = (
      var.router_advertise_config == null
      ? null
      : var.router_advertise_config.mode
    )
    advertised_groups = (
      var.router_advertise_config == null ? null : (
        var.router_advertise_config.mode != "CUSTOM"
        ? null
        : var.router_advertise_config.groups
      )
    )
    dynamic advertised_ip_ranges {
      for_each = (
        var.router_advertise_config == null ? {} : (
          var.router_advertise_config.mode != "CUSTOM"
          ? null
          : var.router_advertise_config.ip_ranges
        )
      )
      iterator = range
      content {
        range       = range.key
        description = range.value
      }
    }
    asn = var.router_asn
  }
}

resource "google_compute_router_peer" "bgp_peer" {
  for_each        = var.tunnels
  region          = var.region
  project         = var.project.project_id
  name            = "${var.name}-${each.key}"
  router          = local.router
  peer_ip_address = each.value.bgp_peer.address
  peer_asn        = each.value.bgp_peer.asn
  advertised_route_priority = (
    each.value.bgp_peer_options == null ? var.route_priority : (
      each.value.bgp_peer_options.route_priority == null
      ? var.route_priority
      : each.value.bgp_peer_options.route_priority
    )
  )
  advertise_mode = (
    each.value.bgp_peer_options == null ? null : each.value.bgp_peer_options.advertise_mode
  )
  advertised_groups = (
    each.value.bgp_peer_options == null ? null : (
      each.value.bgp_peer_options.advertise_mode != "CUSTOM"
      ? null
      : each.value.bgp_peer_options.advertise_groups
    )
  )
  dynamic advertised_ip_ranges {
    for_each = (
      each.value.bgp_peer_options == null ? {} : (
        each.value.bgp_peer_options.advertise_mode != "CUSTOM"
        ? {}
        : each.value.bgp_peer_options.advertise_ip_ranges
      )
    )
    iterator = range
    content {
      range       = range.key
      description = range.value
    }
  }
  interface = google_compute_router_interface.router_interface[each.key].name
}

resource "google_compute_router_interface" "router_interface" {
  for_each   = var.tunnels
  project    = var.project.project_id
  region     = var.region
  name       = "${var.name}-${each.key}"
  router     = local.router
  ip_range   = each.value.bgp_session_range == "" ? null : each.value.bgp_session_range
  vpn_tunnel = google_compute_vpn_tunnel.tunnels[each.key].name
}

resource "google_compute_vpn_gateway" "gateway" {
  name    = var.name
  project = var.project.project_id
  region  = var.region
  network = var.network.self_link
}

resource "google_compute_vpn_tunnel" "tunnels" {
  for_each = var.tunnels
  project  = var.project.project_id
  region   = var.region
  name     = "${var.name}-${each.key}"
  router   = local.router
  peer_ip  = each.value.peer_ip
  shared_secret = (
    each.value.shared_secret == "" || each.value.shared_secret == null
    ? local.secret
    : each.value.shared_secret
  )
  target_vpn_gateway = google_compute_vpn_gateway.gateway.self_link
  depends_on         = [google_compute_forwarding_rule.esp]
}

resource "random_id" "secret" {
  byte_length = 8
}
