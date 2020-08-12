variable "project" {
	description = "The project to add members to"
}

variable "role" {
	type = string
	description = "The role members should be assigned"
}

variable "members" {
	type = list(string)
	description = "The list of members to be assigned the role"
}