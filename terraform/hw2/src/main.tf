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
  family = var.vm_web_image_family
}
resource "yandex_compute_instance" "platform" {
  name        = local.web_vm_name
  platform_id = var.vm_web_instanse_platform_id
  resources {
    cores         = var.vm_web_instanse_cores
    memory        = var.vm_web_instanse_memory
    core_fraction = var.vm_web_instanse_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_instanse_scheduling_policy_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_instanse_network_interface_nat
  }

  metadata = {
    serial-port-enable = var.vm_web_instanse_metadata_serial_port_enable
    ssh-keys           = "${var.vm_web_instanse_username}:${var.vms_ssh_root_key}"
  }

}

resource "yandex_compute_instance" "database" {
  name        = local.db_vm_name
  platform_id = var.vm_db_instanse_platform_id
  resources {
    cores         = var.vm_db_instanse_cores
    memory        = var.vm_db_instanse_memory
    core_fraction = var.vm_db_instanse_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_db_instanse_scheduling_policy_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_db_instanse_network_interface_nat
  }

  metadata = {
    serial-port-enable = var.vm_db_instanse_metadata_serial_port_enable
    ssh-keys           = "${var.vm_db_instanse_username}:${var.vms_ssh_root_key}"
  }

}