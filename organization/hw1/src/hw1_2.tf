resource "yandex_vpc_subnet" "vpc_subnet_public" {
  name           = var.vpc_subnet_public_name
  zone           = var.zone
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = var.vpc_subnet_public_cidr
}

resource "yandex_compute_instance" "nat_instance" {
  name        = var.nat_instance_metadata.name
  resources {
    cores         = var.default_resources.cores
    memory        = var.default_resources.memory
    core_fraction = var.default_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = var.nat_instance_metadata.image_id
    }
  }
  scheduling_policy {
    preemptible = var.default_resources.scheduling_policy_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.vpc_subnet_public.id
    ip_address = var.nat_instance_metadata.ip_address
    nat       = var.public_instance_metadata.nat
  }

  metadata = {
    ssh-keys           = "${var.default_resources.username}:${var.default_resources.ssh-keys}"
  }
}

resource "yandex_compute_instance" "public_instance" {
  name        = var.public_instance_metadata.name
  resources {
    cores         = var.default_resources.cores
    memory        = var.default_resources.memory
    core_fraction = var.default_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = var.public_instance_metadata.image_id
    }
  }
  scheduling_policy {
    preemptible = var.default_resources.scheduling_policy_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.vpc_subnet_public.id
    nat       = var.public_instance_metadata.nat
  }

  metadata = {
    ssh-keys           = "${var.default_resources.username}:${var.default_resources.ssh-keys}"
  }
}