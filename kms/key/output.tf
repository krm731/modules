output "key" {
  value = google_kms_crypto_key.key
}

output "name" {
  value = google_kms_crypto_key.key.name
}
