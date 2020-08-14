variable "name" {
  type        = string
  description = "The name of the node pool"
}

variable "location" {
  type        = string
  description = "The loation of the node pool"
}

variable "cluster" {
  description = "The kubernetes cluster"
}

variable "node_count" {
  type        = number
  description = "The default number of nodes"
}

variable "min_node_count" {
  type        = number
  description = "The minimum number of nodes"
}

variable "max_node_count" {
  type        = number
  description = "The maximum number of nodes"
}

variable "machine_type" {
  type        = string
  description = "The machine type of the nodes"
}

variable "node_locations" {
  type        = list(string)
  description = "Optional list of node locations"
  default     = []
}

variable "project" {
  description = "The name of the project"
}

variable "initial_node_count" {
  type        = number
  description = "Node Count"
  default     = 1
}

variable "max_pods_per_node" {
  type        = number
  description = "pods count"
  default     = 8
}

variable "autoscaling_config" {
  type        = list(string)
  description = "autoscaling config"
  default     = []
}

variable "gke_version" {
  description = "gke version"
  default     = "1.14.10-gke.36"
}
