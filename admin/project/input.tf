variable "name" {
  type        = string
  description = "The display name of the project."
}

variable "project_id" {
  type        = string
  description = "The project ID."
}

variable "org_id" {
  type        = string
  description = "The numeric ID of the organization this project belongs to."
  default     = null
}

variable "folder_id" {
  type        = string
  description = "The numeric ID of the folder this project should be created under."
  default     = null
}

variable "billing_account" {
  type        = string
  description = "The alphanumeric ID of the billing account this project belongs to."
  default     = null
}

variable "skip_delete" {
  type        = bool
  description = "If true, the Terraform resource can be deleted without deleting the Project via the Google API."
  default     = false
}

variable "labels" {
  type        = map(string)
  description = "A set of key/value label pairs to assign to the project."
  default     = null
}

variable "auto_create_network" {
  type        = bool
  description = "Create the 'default' network automatically"
  default     = false
}

variable "services" {
  type        = list(string)
  description = "Enable required services on the project"
  default     = []
}

variable "editors" {
  type        = list(string)
  description = "List of editors"
  default     = []
}
