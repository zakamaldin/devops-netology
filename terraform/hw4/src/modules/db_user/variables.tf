variable "db_cluster_id" {
  type        = string
  default     = ""
  description = "Id of database cluster"
}

variable "db_name" {
  type        = string
  default     = "netoogy_database"
  description = "Database name"
}

variable "db_username" {
  type        = string
  default     = "admin"
  description = "Username for database"
  sensitive   = true
}

variable "db_password" {
  type        = string
  default     = "admin"
  description = "Password for user"
  sensitive   = true
}
