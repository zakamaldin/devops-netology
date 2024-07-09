# resources

variable "default_resources" {
  type = object({
    cores = number
    memory = number
    core_fraction = number
    scheduling_policy_preemptible = bool
    platform_id = string
    serial_port_enable = number
    username = string
    ssh-keys = string
    })

    default = {
        cores = 4
        memory = 8
        core_fraction = 5
        scheduling_policy_preemptible = true
        platform_id = "standard-v3"
        serial_port_enable = 1
        username = "admin"
        ssh-keys = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGcHa3AIZyjjlUMJkOA/6VJpY/c/U8fOn25cexJpxFhm"
    }
    description = "Default resources of VMs"
}

variable "nat_instance_metadata" {
  type = object({
    name       = string
    image_id   = string
    ip_address = string
    nat        = bool

    })
    default = {
        name       = "nat-instance"
        image_id   = "fd80mrhj8fl2oe87o4e1"
        ip_address = "192.168.10.254"
        nat        = true

    }
    description = "Default values of NAT instance"
}

variable "public_instance_metadata" {
  type = object({
    name     = string
    image_id = string
    nat      = bool

    })
    default = {
        name     = "public-instance"
        image_id = "fd8qiisldh8geahpgicl"
        nat      = true

    }
    description = "Default values of public instance"
}

variable "private_instance_metadata" {
  type = object({
    name = string
    image_id = string

    })
    default = {
        name = "private-instance"
        image_id = "fd8qiisldh8geahpgicl"

    }
    description = "Default values of private instance"
}