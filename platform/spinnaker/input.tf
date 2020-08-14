variable "project" {
  description = "The project where the spinnaker instance is deployed"
}

variable "spinnaker_version" {
  description = "The version of spinnaker deployed"
  type        = string
  default     = "1.19.12"
}

variable "storage_bucket" {
  description = "The storage bucket for the spinnaker instance"
}

variable "service_account_key" {
  description = "The google service account key for this spinnaker instance"
}

variable "namespace" {
  default     = "spinnaker"
  description = "The namespace for the spinnaker deployment"
}

variable "spinnaker_k8s_sa" {
  default     = "spinnakersa"
  description = "The kubernetes service account for the spinnaker deployment"
}