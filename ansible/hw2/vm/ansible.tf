resource "local_file" "hosts" {
    depends_on = [ yandex_compute_instance.vm ]
    content = templatefile("${path.module}/hosts.tftpl",
        { 
            vm =  yandex_compute_instance.vm
        }
    )

  filename = "${abspath(path.module)}/../playbook/inventory/prod.yml"
}
