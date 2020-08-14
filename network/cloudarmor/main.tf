resource "google_compute_security_policy" "cloudarmor-security-policy" {
  project     = var.project_id
  for_each    = var.cloud_armor
  name        = each.key
  description = each.value.description
  dynamic "rule" {
    for_each = lookup(each.value, "versioned_expr", null)
    content {
      action   = rule.value.action
      priority = rule.value.priority
      match {
        versioned_expr = rule.value.versioned_expr_name
        config {
          src_ip_ranges = flatten(rule.value.src_ip_ranges)
        }
      }
      description = rule.value.rule_description
    }
  }
  dynamic "rule" {
    for_each = lookup(each.value, "expr", null)
    content {
      action   = rule.value.action
      priority = rule.value.priority
      match {
        expr {
          expression = rule.value.expression
        }
      }
      description = rule.value.rule_description
      preview     = (length(rule.value) == 4 ? false : rule.value.preview)
    }
  }
}