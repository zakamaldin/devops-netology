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

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "<your_ssh_ed25519_key>"
  description = "ssh-keygen -t ed25519"
}

###vm_web vars

variable "vm_web_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "OS image family for WEB VM"
}

variable "vm_web_instanse_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "Name of VM in Cloud"
}

variable "vm_web_instanse_username" {
  type        = string
  default     = "ubuntu"
  description = "Name of username in VM"
}

variable "vm_web_instanse_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Id of CPU platform in Cloud"
}

variable "vm_web_instanse_cores" {
  type        = number
  default     = 2
  description = "Number of CPU in VM"
}

variable "vm_web_instanse_memory" {
  type        = number
  default     = 1
  description = "Number of RAM in VM(GB)"
}

variable "vm_web_instanse_core_fraction" {
  type        = number
  default     = 20
  description = "Percent of CPU performance in VM"
}

variable "vm_web_instanse_scheduling_policy_preemptible" {
  type        = bool
  default     = true
  description = "Make VM an interruptible"
}

variable "vm_web_instanse_network_interface_nat" {
  type        = bool
  default     = true
  description = "Enable NAT for VM"
}

variable "vm_web_instanse_metadata_serial_port_enable" {
  type        = number
  default     = 1
  description = "Enable serial-port to VM from Cloud UI"
}