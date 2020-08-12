resource "google_compute_network" "vpc" {
  name                            = var.name
  auto_create_subnetworks         = false
  routing_mode                    = "GLOBAL"
  project                         = var.project.project_id
  description                     = var.description
	delete_default_routes_on_create = var.delete_routes
}

