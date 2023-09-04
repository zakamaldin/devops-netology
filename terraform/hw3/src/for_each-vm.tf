variable "named_vms_params" {
  description = "params for named vms"
  type = list(object(
    {
      vm_name       = string
      cpu           = number
      ram           = number
      disk          = number

  }))
  default = [
    {
      vm_name       = "main"
      cpu           = 2
      ram           = 1
      disk          = 5
    },
    {
      vm_name       = "replica"
      cpu           = 4
      ram           = 2
      disk          = 7
    },
  ]
}

resource "yandex_compute_instance" "named_vms" {
    for_each = {
      for vm in var.named_vms_params:
      vm.vm_name => vm 
    }
    name = each.value.vm_name
    platform_id = "standard-v1"
    
    resources {
        cores         = each.value.cpu
        memory        = each.value.ram
        core_fraction = 5
    }

    network_interface {
        subnet_id = yandex_vpc_subnet.develop.id
        nat       = true
    }

    boot_disk {
        initialize_params {
            image_id = data.yandex_compute_image.ubuntu.image_id
            type = "network-hdd"
            size = each.value.disk
        }
    }   

    scheduling_policy { preemptible = true }

    metadata = {
        serial-port-enable = 1
        ssh-keys           = "ubuntu:${local.ssh_pub_key}"
    }
    allow_stopping_for_update = true
    depends_on = [yandex_compute_instance.counted_vms]

}