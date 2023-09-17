data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "counted_vms" {
    count = 2
    name = "web-${count.index + 1}"
    platform_id = "standard-v1"
    
    resources {
        cores         = 2
        memory        = 1
        core_fraction = 5
    }

    network_interface {
        subnet_id = yandex_vpc_subnet.develop.id
        nat       = true
        security_group_ids = [yandex_vpc_security_group.example.id]
    }

    boot_disk {
        initialize_params {
            image_id = data.yandex_compute_image.ubuntu.image_id
            type = "network-hdd"
            size = 5
        }
    }   

    scheduling_policy { preemptible = true }

    metadata = {
        serial-port-enable = 1
        ssh-keys           = "ubuntu:${local.ssh_pub_key}"
    }
  allow_stopping_for_update = true
}