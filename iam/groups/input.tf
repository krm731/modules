variable "project" {
	description = "The project to add members to"
}

variable "group" {
	type = string
	description = "The group to assign the roles to"
}

variable "roles" {
	type = list(string)
	description = "A list of roles to assign to a group"
}

