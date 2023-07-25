# resources

variable "vms_resources" {
  type = map(object({
    cores = number
    memory = number
    core_fraction = number
    username = string
    }))
    default = {
        "vm_web_resources" = {
            cores = 2
            memory = 1
            core_fraction = 20
            username = "ubuntu"
        }
        "vm_db_resources" = {
            cores = 2
            memory = 2
            core_fraction = 20
            username = "postgres"
        }
    }
    description = "Resources of VMs"
}

variable "vms_metadata" {
  type = object({
    image_family = string
    platform_id = string
    serial_port_enable = number
    ssh-keys = string
    nat = bool
    scheduling_policy_preemptible = bool
    })
    default = {
            image_family = "ubuntu-2004-lts"
            platform_id = "standard-v3"
            serial_port_enable = 1
            ssh-keys = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ+7YD4VM9/e97tMiNfaSgJNbHb9KC2ArCu4JwulkCgB admin\\admin@ADMIN"
            nat = true
            scheduling_policy_preemptible = true
        }
    description = "Metadata of VMs"
}