data "yandex_compute_image" "centos7" {
  family = "centos-7"
}

variable "metrics_cluster_params" {
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
      vm_name       = "clickhouse"
      cpu           = 2
      ram           = 4
      disk          = 10
    },
    {
      vm_name       = "vector"
      cpu           = 2
      ram           = 4
      disk          = 10
    },
    {
      vm_name       = "lighthouse"
      cpu           = 2
      ram           = 2
      disk          = 10
    },
  ]
}

resource "yandex_compute_instance" "metrics_cluster" {
    for_each = {
      for vm in var.metrics_cluster_params:
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
            image_id = data.yandex_compute_image.centos7.image_id
            type = "network-hdd"
            size = each.value.disk
        }
    }   

    scheduling_policy { preemptible = true }

    metadata = {
        serial-port-enable = 1
        ssh-keys           = "centos:${local.ssh_pub_key}"
    }
    allow_stopping_for_update = true

}