resource "google_kms_key_ring" "keyring" {
  name     = var.name
  location = var.location
}
