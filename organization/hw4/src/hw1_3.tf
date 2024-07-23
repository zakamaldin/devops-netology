resource "yandex_vpc_subnet" "vpc_subnet_private" {
  name           = var.vpc_subnet_private_name
  zone           = var.zone
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = var.vpc_subnet_private_cidr
  route_table_id = "${yandex_vpc_route_table.route_table.id}"
}

resource "yandex_compute_instance" "private_instance" {
  name        = var.private_instance_metadata.name
  resources {
    cores         = var.default_resources.cores
    memory        = var.default_resources.memory
    core_fraction = var.default_resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = var.private_instance_metadata.image_id
    }
  }
  scheduling_policy {
    preemptible = var.default_resources.scheduling_policy_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.vpc_subnet_private.id
  }

  metadata = {
    ssh-keys = "${var.default_resources.username}:${var.default_resources.ssh-keys}"
  }
}

resource "yandex_vpc_route_table" "route_table" {
  network_id = "${yandex_vpc_network.vpc.id}"
  name       = var.route_table_name

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "${yandex_compute_instance.nat_instance.network_interface[0].ip_address}"
  }
}