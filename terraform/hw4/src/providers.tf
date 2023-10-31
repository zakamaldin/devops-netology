terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.101.0"
    }

    template = {
      source = "hashicorp"
      version = "2.2.0"
    }
    vault = {
      source = "hashicorp"
      version = "3.21.0"
    }
  }
  required_version = ">=0.13"
  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket = "tfstate-netology-develop"
    region = "ru-central1"
    key = "terraform.tfstate"
    skip_region_validation = true
    skip_credentials_validation = true
    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gpgpkko4enmuce4gmv/etng0d0fidngcledv727"
    dynamodb_table = "tflock"
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}

provider "vault" {
    address = "http://127.0.0.1:8200"
    skip_tls_verify = true
    token = "education"
        # checkov:skip=CKV_SECRET_6: education
}