resource "google_kms_crypto_key" "key" {
  name            = var.name
  key_ring        = var.keyring.id
  rotation_period = var.rotation_period
  purpose         = var.purpose

  version_template {
    algorithm        = var.algorithm
    protection_level = var.protection_level
  }

  lifecycle {
    prevent_destroy = true
  }
}