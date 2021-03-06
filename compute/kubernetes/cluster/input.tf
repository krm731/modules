variable "project" {
	description = "The project for the cluster"
}

variable "name" {
	type = string
	description = "The name of the cluster"
}

variable "description" {
	type = string
	description = "The description of the cluster"
	default = null
}

variable "node_locations" {
	type = list(string)
	description = "Optional list of node locations"
	default = []
}

variable "location" {
	type = string 
	description = "The location of the cluster"
}

variable "network" {
	description = "The network name for the cluster vpc"
}

variable "subnetwork" {
	description = "The subnet name for the cluster vpc"
}

variable "initial_node_count" {
	type = number 
	description = "The initial node count"
	default = 1
}

variable "horizontal_pod_autoscaling" {
	type = bool
	description = "Defaults to true for production configuration"
	default = true
}

variable "http_load_balancing" {
	type = bool 
	description = "Defaults to true for production configuration"
	default = true
}

variable "dns_cache_config" {
	type = bool
	description = "Defaults to false for production configuration"
	default = false
}

variable "network_policy_config" {
	type = bool
	description = "Defaults to false for production configuration"
	default = false
}

variable "maintenance_start_time" {
	type = string
	description = "The start time for maintenance of the cluster"
	default = "02:00"
}

variable "isprivatecluster" {
	type = bool
	description = "Private cluster"
	default = true
}

variable "environment" {
	type = string
	description = "Environment type"
	default = "develop"
}

variable "master_ipv4_cidr_block"{
	type = string
	description = "Master ipv4 CIDR block"
	default = "172.16.0.32/28"
}

variable "master_auth_cidr_block"{
	type = string
	description = "Master ipv4 CIDR block"
	default = "34.120.149.40/28"
}

variable "cluster_secondary_range_name" {
  description = "The name of the secondary range within the subnetwork for the cluster to use"
  default = "10.10.11.0/24"
}

variable "network_policy" {
  type        = bool
  description = "Enable network policy addon"
  default     = true
}

variable "network_policy_provider" {
  type        = string
  description = "The network policy provider."
  default     = "CALICO"
}