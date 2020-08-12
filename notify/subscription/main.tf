resource "google_pubsub_subscription" "subscription" {
  project = var.project.project_id
  name    = var.name
  topic   = var.topic.name
}