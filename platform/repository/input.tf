variable "name" {
  type        = string
  description = "The repository name"
}

variable "project" {
  description = "The project that owns the repository"
}

variable "topic" {
  type        = string
  description = "The pub/sub topic name"
}

variable "service_account" {
  description = "The service account to send pub/sub messages"
}

variable "iam_roles" {
  description = "iam roles for topic"
  type        = list(string)
  default     = []
}

variable "iam_members" {
  description = "IAM members for each topic role"
  type        = map(list(string))
  default     = {}
}

variable "module_depends_on" {
  type        = any
  default     = []
  description = "Module dependency variable"
}