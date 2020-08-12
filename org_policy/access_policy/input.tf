variable "org_id" {
  description = "The ID of the project to create the bucket in."
  type        = string
  default     = null
}


variable "vpcsc_access_policy_name" {
  description = "Name of the org policy"
  type        = string
  default     = null
}
