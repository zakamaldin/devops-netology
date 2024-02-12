variable "named_vms_params" {
  description = "params for named vms"
  type = list(object(
    {
      vm_name       = string
      cpu           = number
      ram           = number
  }))
  default = [
    {
      vm_name       = "jenkins-master"
      cpu           = 2
      ram           = 4
    },
    {
      vm_name       = "jenkins-agent"
      cpu           = 2
      ram           = 4
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
        subnet_id = yandex_vpc_subnet.ci_cd_subnet.id
        nat       = true
    }

    boot_disk {
        initialize_params {
            image_id = data.yandex_compute_image.image.image_id
        }
    }   

    scheduling_policy { preemptible = true }

    metadata = {
        serial-port-enable = 1
        ssh-keys           = "fedora:${local.ssh_pub_key}"
    }
    allow_stopping_for_update = true
}