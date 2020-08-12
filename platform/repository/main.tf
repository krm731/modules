resource "google_pubsub_topic" "topic" {
	project = var.project.project_id
  name    = var.topic
}

resource "google_sourcerepo_repository" "repository" {
  project = var.project.project_id
  name    = var.name
  pubsub_configs {
      topic = google_pubsub_topic.topic.id
      message_format = "JSON"
      service_account_email = var.service_account.email
  }

	depends_on = [var.module_depends_on]
}

resource "google_sourcerepo_repository_iam_binding" "bindings" {
  for_each   = toset(var.iam_roles)
  project    = var.project.project_id
  repository = google_sourcerepo_repository.repository.name
  role       = each.value
  members    = lookup(var.iam_members, each.value, [])
}