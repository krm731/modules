output "keyring" {
  value = google_kms_key_ring.keyring
}

output "id" {
  value = google_kms_key_ring.keyring.id
}
