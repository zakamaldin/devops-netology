output "info_about_all_instances" {
  value = [for value in concat(yandex_compute_instance.counted_vms, values(yandex_compute_instance.named_vms), [yandex_compute_instance.storage]): 
    {
      "name" = value.name
      "id"  = value.id
      "fqdn"  = value.fqdn
    }
  ]
}

