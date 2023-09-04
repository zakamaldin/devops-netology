resource "local_file" "hosts_cfg" {
    depends_on = [ yandex_compute_instance.counted_vms, yandex_compute_instance.named_vms, yandex_compute_instance.storage ]
    content = templatefile("${path.module}/hosts.tftpl",
        { 
            webservers =  yandex_compute_instance.counted_vms,
            databases =  yandex_compute_instance.named_vms,
            storage =  [yandex_compute_instance.storage],
        }
    )

  filename = "${abspath(path.module)}/hosts.cfg"
}