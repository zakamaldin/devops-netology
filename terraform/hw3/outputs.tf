output "external_ip_addresses_of_vms" {
  value = [for value in yandex_compute_instance.counted_vms: value.id]
}