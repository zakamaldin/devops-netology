resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


data "yandex_compute_image" "ubuntu" {
  family = var.vms_metadata.image_family
}
resource "yandex_compute_instance" "platform" {
  name        = local.web_vm_name
  platform_id = var.vms_metadata.platform_id
  resources {
    cores         = var.vms_resources.vm_web_resources.cores
    memory        = var.vms_resources.vm_web_resources.memory
    core_fraction = var.vms_resources.vm_web_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vms_metadata.scheduling_policy_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vms_metadata.nat
  }

  metadata = {
    serial-port-enable = var.vms_metadata.serial_port_enable
    ssh-keys           = "${var.vms_resources.vm_web_resources.username}:${var.vms_metadata.ssh-keys}"
  }

}

resource "yandex_compute_instance" "database" {
  name        = local.db_vm_name
  platform_id = var.vms_metadata.platform_id
  resources {
    cores         = var.vms_resources.vm_db_resources.cores
    memory        = var.vms_resources.vm_db_resources.memory
    core_fraction = var.vms_resources.vm_db_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vms_metadata.scheduling_policy_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vms_metadata.nat
  }

  metadata = {
    serial-port-enable = var.vms_metadata.serial_port_enable
    ssh-keys           = "${var.vms_resources.vm_db_resources.username}:${var.vms_metadata.ssh-keys}"
  }

}