output "external_ip_addresses_of_vms" {
  value = {
    "web" = "${yandex_compute_instance.platform.network_interface[0].nat_ip_address}"
    "db"  = "${yandex_compute_instance.database.network_interface[0].nat_ip_address}"
  }
}