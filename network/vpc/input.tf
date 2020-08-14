variable "name" {
  type        = string
  description = "The name of the vpc to create"
}

variable "project" {
  description = "The name of the project"
}

variable "description" {
  type        = string
  description = "A description of the vpc"
  default     = null
}

variable "delete_routes" {
  type        = bool
  description = "Delete optional routes on create"
  default     = false
}

variable "shared" {
  description = "Define the vpc as a shared"
  type        = bool
  default     = false
}