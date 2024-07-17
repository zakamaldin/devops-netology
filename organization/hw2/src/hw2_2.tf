

resource "yandex_compute_instance_group" "lamp-instance-group" {
  depends_on = [ yandex_iam_service_account.netology-sa ]
  name                = "lamp-instance-group"
  folder_id           = var.folder_id
  service_account_id  = "${yandex_iam_service_account.netology-sa.id}"
  deletion_protection = false
  instance_template {
    platform_id = var.default_resources.platform_id
    resources {
        cores         = var.default_resources.cores
        memory        = var.default_resources.memory
        core_fraction = var.default_resources.lamp_core_fraction
    }
    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = var.lamp_image_id
        size     = 4
      }
    }
    network_interface {
      network_id = "${yandex_vpc_network.vpc.id}"
      subnet_ids = ["${yandex_vpc_subnet.vpc_subnet_public.id}"]
      nat        = var.public_instance_metadata.nat
    }
    metadata = {
        ssh-keys  = "${var.default_resources.username}:${var.default_resources.ssh-keys}"
        user-data = data.template_file.lamp_cfg.rendered
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = ["ru-central1-a"]
  }

  deploy_policy {
    max_unavailable = 2
    max_creating    = 2
    max_expansion   = 2
    max_deleting    = 2
  }

  health_check {
    interval = 30
    timeout  = 10
    unhealthy_threshold = 10
    http_options {
      path = "/index.html"
      port = 80
    }
  }
  load_balancer {
    target_group_name   = "lamp-group"
  }
}

data "template_file" "lamp_cfg" {
  template = "${file("./hw2-cloud-init.tftpl")}"

  vars = {
    storage  = "${yandex_storage_bucket.zakamaldin-storage.bucket}",
    object   = "${yandex_storage_object.zakamaldin-storage-object.key}",
    ssh_key  = var.default_resources.ssh-keys,
    username = var.default_resources.username
  }
}
