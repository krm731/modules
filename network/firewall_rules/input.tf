variable "project" {
  description = "The project for the network"
}

variable "network" {
  description = "The network for the firewall rules"
}

variable "allow_ingress" {
  description = "List of rules to allow ingress"
  type = map(object({
    description          = string
    ranges               = list(string)
    sources              = list(string)
    targets              = list(string)
    use_service_accounts = bool
    rules = list(object({
      protocol = string
      ports    = list(string)
    }))
    extra_attributes = map(string)
  }))
  default = {}
}

variable "deny_ingress" {
  description = "List of rules to deny ingress"
  type = map(object({
    description          = string
    ranges               = list(string)
    sources              = list(string)
    targets              = list(string)
    use_service_accounts = bool
    rules = list(object({
      protocol = string
      ports    = list(string)
    }))
    extra_attributes = map(string)
  }))
  default = {}
}

variable "allow_egress" {
  description = "List of rules to allow egress"
  type = map(object({
    description          = string
    ranges               = list(string)
    sources              = list(string)
    targets              = list(string)
    use_service_accounts = bool
    rules = list(object({
      protocol = string
      ports    = list(string)
    }))
    extra_attributes = map(string)
  }))
  default = {}
}
variable "deny_egress" {
  description = "List of rules to deny egress"
  type = map(object({
    description          = string
    ranges               = list(string)
    sources              = list(string)
    targets              = list(string)
    use_service_accounts = bool
    rules = list(object({
      protocol = string
      ports    = list(string)
    }))
    extra_attributes = map(string)
  }))
  default = {}
}