variable "name" {
  type        = string
  description = "Name of the SSL policy"
}

variable "project_id" {
  type        = string
  description = "id of the project"
}

variable "min_tls_version" {
  type        = string
  description = " The minimum version of SSL protocol"
  default     = "TLS_1_2"
}

variable "profile" {
  type        = string
  description = "specifies the set of SSL features that can be used by the load balancer when negotiating SSL with clients.If using CUSTOM, the set of SSL features to enable must be specified in the customFeatures"
  default     = "MODERN"
}

variable "custom_features" {
  type        = list(string)
  description = "specifies the set of SSL features that can be used by the load balancer when negotiating SSL with clients"
  default     = []
}
