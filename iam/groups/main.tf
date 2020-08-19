resource "google_project_iam_member" "role" {
  for_each   = toset(var.roles)
  project    = var.project.project_id
  role       = each.value
  member     = var.group
}