terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"
}

resource "yandex_vpc_network" "net" {
  name = var.env_name
}
resource "yandex_vpc_subnet" "net" {
  name           = "${var.env_name}_${each.key + 1}" 
  network_id     = yandex_vpc_network.net.id

  for_each = {
      for idx, subnet in var.subnets:
      idx => subnet
    }
  
  zone            = each.value.zone
  v4_cidr_blocks  = [ each.value.cidr ]

}