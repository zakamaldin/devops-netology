###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "zone_b" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "zone_d" {
  type        = string
  default     = "ru-central1-d"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vpc_subnet_public_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_subnet_public_cidr_zone_b" {
  type        = list(string)
  default     = ["192.168.11.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_subnet_public_cidr_zone_d" {
  type        = list(string)
  default     = ["192.168.12.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}
variable "vpc_subnet_public_name" {
  type        = string
  default     = "public"
  description = "VPC network & subnet name"
}

variable "vpc_subnet_public_name_zone_b" {
  type        = string
  default     = "public-b"
  description = "VPC network & subnet name"
}

variable "vpc_subnet_public_name_zone_d" {
  type        = string
  default     = "public-d"
  description = "VPC network & subnet name"
}

variable "vpc_subnet_private_cidr" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_subnet_private_cidr_zone_b" {
  type        = list(string)
  default     = ["192.168.21.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_subnet_private_name" {
  type        = string
  default     = "private"
  description = "VPC network & subnet name"
}

variable "vpc_subnet_private_name_zone_b" {
  type        = string
  default     = "private-b"
  description = "VPC network & subnet name"
}

variable "vpc_name" {
  type        = string
  default     = "org_hw1_vpc"
  description = "VPC network & subnet name"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "<your_ssh_ed25519_key>"
  description = "ssh-keygen -t ed25519"
}

variable "route_table_name" {
  type        = string
  default     = "route-table"
  description = "Name of route table"
}

variable "sa_access_key" {
  type        = string
}

variable "sa_secret_key" {
  type        = string
}

variable "lamp_image_id" {
  type        = string
  default     = "fd827b91d99psvq5fjit"
  description = "ID for LAMP stack image"
}
