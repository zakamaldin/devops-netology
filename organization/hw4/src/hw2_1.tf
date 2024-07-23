resource "yandex_iam_service_account" "netology-sa" {
  folder_id = var.folder_id
  name      = "netology-sa"
}

resource "yandex_resourcemanager_folder_iam_member" "netology-sa-admin" {
  folder_id = var.folder_id
  role      = "admin"
  member    = "serviceAccount:${yandex_iam_service_account.netology-sa.id}"
}

resource "yandex_iam_service_account_static_access_key" "netology-sa-static-key" {
  service_account_id = yandex_iam_service_account.netology-sa.id
  description        = "static access key for object storage"
}

resource "yandex_storage_bucket" "zakamaldin-storage" {
  access_key = var.sa_access_key
  secret_key = var.sa_secret_key
  bucket     = "zakamaldin-storage-2024"
  acl        = "public-read"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.hw3-symetric-key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "yandex_storage_object" "zakamaldin-storage-object" {
  bucket     = "zakamaldin-storage-2024"
  key        = "sysadmin.jpg"
  source     = "../images/sysadmin.jpg"
  access_key = yandex_iam_service_account_static_access_key.netology-sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.netology-sa-static-key.secret_key
}