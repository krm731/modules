resource "google_cloudbuild_trigger" "trigger" {

  project       = var.project.project_id
  name          = var.name
  filename      = var.filename
  substitutions = var.substitutions

  trigger_template {
    branch_name = var.branch
    repo_name   = var.repository.name
  }

  depends_on = [var.module_depends_on]
}