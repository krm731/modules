resource "google_kms_key_ring" "keyring" {
  project  = var.project
  name     = var.name
  location = var.location
}
