variable "keyring" {
  description = "The keyring to create the key in"
}

variable "name" {
  description = "The name of the encryption key"
  type        = string
}

//Default rotation is 90 days
variable "rotation_period" {
  description = "The rotation period for the key"
  type        = string
  default     = "7776000s"
}

variable "purpose" {
  description = "The purpose of the key"
  type        = string
  default     = "ENCRYPT_DECRYPT"
}

variable "algorithm" {
  description = "The algorithm to use for encryption/decryption"
  type        = string
  default     = "GOOGLE_SYMMETRIC_ENCRYPTION"
}

variable "protection_level" {
  description = "Software or HSM"
  type        = string
  default     = "HSM"
}

