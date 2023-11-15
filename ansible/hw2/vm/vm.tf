data "yandex_compute_image" "centos7" {
  family = "centos-7"
}

resource "yandex_compute_instance" "vm" {
    name = "vm"
    platform_id = "standard-v1"
    
    resources {
        cores         = 2
        memory        = 1
        core_fraction = 5
    }

    network_interface {
        subnet_id = yandex_vpc_subnet.develop.id
        nat       = true
    }

    boot_disk {
        initialize_params {
            image_id = data.yandex_compute_image.centos7.image_id
        }
    }   

    scheduling_policy { preemptible = true }

    metadata = {
        serial-port-enable = 1
        ssh-keys           = "centos:${local.ssh_pub_key}"
    }
  allow_stopping_for_update = true
}