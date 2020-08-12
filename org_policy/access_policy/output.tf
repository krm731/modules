output "policy_id" {
  description = "The policy id of the access policy"
  value       = google_access_context_manager_access_policy.access_policy.title
}
