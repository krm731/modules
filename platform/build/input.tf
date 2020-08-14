variable "project" {
  description = "The project"
}

variable "name" {
  description = "The name of the cloud build trigger"
  type        = string
}

variable "filename" {
  description = "The name of the cloud build definition file"
  type        = string
  default     = "cloudbuild.yaml"
}

variable "substitutions" {
  description = "Substitutions to be made when building"
  type        = map(string)
  default     = null
}

variable "repository" {
  description = "The name of the repository to build"
}

variable "branch" {
  description = "The name of the branch of the repository to build"
  type        = string
}

variable "module_depends_on" {
  type        = any
  default     = []
  description = "Module dependency variable"
}