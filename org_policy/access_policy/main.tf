resource "google_access_context_manager_access_policy" "access_policy" {
  parent = "organizations/${var.org_id}"
  title  = var.vpcsc_access_policy_name
}
