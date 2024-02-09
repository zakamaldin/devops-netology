resource "local_file" "hosts" {
    depends_on = [ yandex_compute_instance.named_vms ]
    content = templatefile("${path.module}/hosts.tftpl",
        { 
            vms =  yandex_compute_instance.named_vms
        }
    )

  filename = "${abspath(path.module)}/../inventory/cicd/hosts.yml"
}
