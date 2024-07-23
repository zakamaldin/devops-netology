
variable "mysql_cluster_metadata" {
  type = object({
    name                    = string
    database_name           = string
    environment             = string
    version                 = string
    resource_preset_id      = string
    disk_size               = number
    disk_type_id            = string
    maintenance_window_type = string
    backup_hours            = number
    backup_minutes          = number
    deletion_protection     = bool
    host1_name              = string
    host2_name              = string
    })

    default = {
        name                    = "hetotlogy_mysql_cluster_hw4"
        database_name           = "netology_db"
        environment             = "PRESTABLE"
        version                 = "8.0"
        resource_preset_id      = "b1.medium"
        disk_size               = 20
        disk_type_id            = "network-hdd"
        maintenance_window_type = "ANYTIME"
        backup_hours            = 23
        backup_minutes          = 59
        deletion_protection     = true
        host1_name              = "mysql_cluster_node_1"
        host2_name              = "mysql_cluster_node_2"
    }
    description = "Default resources of mysql cluster"
}

variable "db_username" {
  type        = string
}

variable "db_password" {
  type        = string
}