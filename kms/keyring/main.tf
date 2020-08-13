resource "google_kms_key_ring" "keyring" {
	project  = var.project.project_id
  name     = var.name
  location = var.location
}