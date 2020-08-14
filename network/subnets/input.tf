variable "project" {
  description = "The project for the subnets"
}

variable "network" {
  description = "The network for the subnet"
}

variable "subnets" {
  type        = list
  description = "A list of subnets"
}