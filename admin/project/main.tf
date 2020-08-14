resource "google_project" "project" {
  name                = var.name
  project_id          = var.project_id
  org_id              = var.org_id
  folder_id           = var.folder_id
  billing_account     = var.billing_account
  skip_delete         = var.skip_delete
  labels              = var.labels
  auto_create_network = false
}

resource "google_project_service" "services" {
  for_each = toset(var.services)
  project  = google_project.project.project_id
  service  = each.key

  disable_on_destroy         = false
  disable_dependent_services = false
}

