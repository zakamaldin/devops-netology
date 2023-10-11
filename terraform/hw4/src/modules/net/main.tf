terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"
}

resource "yandex_vpc_network" "net" {
  name = var.network_name
}
resource "yandex_vpc_subnet" "net" {
  name           = var.subnet_name
  network_id     = yandex_vpc_network.net.id
}