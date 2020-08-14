resource "google_compute_global_address" "global_public_ip" {
  name = var.name
  project = var.project
}