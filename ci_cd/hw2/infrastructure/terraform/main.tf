resource "yandex_vpc_network" "ci_cd_net" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "ci_cd_subnet" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.ci_cd_net.id
  v4_cidr_blocks = var.default_cidr
}

data "yandex_compute_image" "centos7" {
  family = "centos-7"
}
