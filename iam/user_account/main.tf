resource "google_project_iam_member" "role" {
  for_each   = toset(var.members)
  project    = var.project.project_id
  role       = var.role
  member     = each.value
}

