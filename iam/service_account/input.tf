variable "account_id" {
	type = string
	description = "The name of the service account"
}

variable "display_name" {
	type = string
	description = "The display name for the service account"
}

variable "description" {
	type = string
	description = "A description of the service account"
}

variable project {
	description = "The project to create the service account in"
}

variable roles {
	type = list(string)
	description = "A list of the roles the service account should have in the project"
}

variable keys {
	type = bool
	description = "Generate keys?"
	default = false
}
