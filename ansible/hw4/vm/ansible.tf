resource "local_file" "hosts" {
    depends_on = [ yandex_compute_instance.metrics_cluster ]
    content = templatefile("${path.module}/hosts.tftpl",
        { 
            vms =  yandex_compute_instance.metrics_cluster
        }
    )

  filename = "${abspath(path.module)}/../playbook/inventory/prod.yml"
}
