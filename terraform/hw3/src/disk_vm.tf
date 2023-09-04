resource "yandex_compute_disk" "disk" {
    count = 3
    name       = "disk-${count.index + 1}"
    type       = "network-hdd"
    zone       = var.default_zone
    size       = 1
}

resource "yandex_compute_instance" "storage" {
    name = "storage"
    platform_id = "standard-v1"
    depends_on = [ yandex_compute_disk.disk ]
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

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.disk
    content {
      disk_id = secondary_disk.value.id
    }
  }
}