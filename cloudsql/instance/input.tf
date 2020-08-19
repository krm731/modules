variable "project" {
  description = "The project to create the database in"
}

variable "network" {
  description = "The VPC network to create the database in"
}

variable "region" {
  description = "The region to create the database in"
  type        = string
}

variable "instance_name" {
  description = "The name of the database instance"
  type        = string
}

variable "encryption_key_name" {
  description = "Encryption key name if using customer managed encryption keys"
  type        = string
  default     = null
}

//This should really be a many to one relationship
variable "database_name" {
  description = "Name of the database to create in the instance"
  type        = string
}

//These should be a map under the database name
variable "user" {
  description = "Name of the database user to create"
  type        = string
  default     = "admin"
}

variable "password" {
  description = "Password for the user"
  type        = string
  default     = "admin"
}

variable "classification" {
  description = "Classification of database"
  type        = string
  default     = "highly confidential"
}

variable "owner" {
  description = "Database Owner"
  type        = string
  default     = ""
}

