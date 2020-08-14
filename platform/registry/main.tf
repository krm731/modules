resource "google_container_registry" "registry" {
  project  = var.project.project_id
  location = "EU"
}

resource "google_storage_bucket_iam_member" "viewer" {
  for_each = toset(var.viewers)
  bucket   = google_container_registry.registry.id
  role     = "roles/storage.objectViewer"
  member   = each.value
}

resource "google_storage_bucket_iam_member" "admin" {
  for_each = toset(var.admin)
  bucket   = google_container_registry.registry.id
  role     = "roles/storage.admin" // 
  member   = each.value
}
