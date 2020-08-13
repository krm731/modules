resource "google_compute_ssl_policy" "ssl_policy" {
  name            = var.name
  project         = var.project_id
  min_tls_version = var.min_tls_version
  profile         = var.profile
  custom_features = var.custom_features
}