resource "google_service_account" "account" {
  account_id   = var.account_id
  display_name = var.display_name
	description  = var.description	
	project      = var.project.project_id
}

resource "google_service_account_key" "keys" {
	count = var.keys ? 1 : 0
  service_account_id = google_service_account.account.email
}

resource "google_project_iam_member" "role" {
	for_each = toset(var.roles)
	project = var.project.project_id 
	role    = each.value
  member  = "serviceAccount:${google_service_account.account.email}"
}