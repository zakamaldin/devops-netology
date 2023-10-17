variable "net_id" {
  type        = string
  default     = ""
  description = "Id of resource's network"
}

variable "subnet_id" {
  type        = string
  default     = ""
  description = "Id of resource's subnet"
}

variable "cluster_name" {
  type        = string
  default     = "db_cluster"
  description = "Name for your DataBase cluster"
}

variable "HA" {
  type        = bool
  default     = false
  description = "Multiple host cluster or single"
}