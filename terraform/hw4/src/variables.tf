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
  description = "VPC network&subnet name"
}

###common vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
  description = "ssh-keygen -t ed25519"
}

###example vm_web var
variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "example vm_web_ prefix"
}

###example vm_db var
variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "example vm_db_ prefix"
}

variable "image_family" {
  type    = string
  default = "ubuntu-2204-lts"
}

variable "db_password" {
  type        = string
  description = "User password for database in cluster"
}

variable "test_ip" {
  type        = string
  description = "ip-адрес"
  default     = "192.168.0.1"
  # default     = "1920.1680.0.1"
  validation {
    condition = can(regex("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$",var.test_ip))
    error_message = "Invalid ip."
  }


} 

variable "test_ip_list" {
  type        = list(string)
  description = "список ip-адресов"
  default     = ["192.168.0.1", "1.1.1.1", "127.0.0.1"]
  # default     = ["192.168.0.1", "1.1.1.1", "1270.0.0.1"]
  validation {
    condition = alltrue([for ip in var.test_ip_list : can(regex("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", ip))])
    error_message = "Invalid ip"
  }
} 

variable "test_lowercase_string" {
  type        = string
  description = "Строка в нижнем регистре"
  default     = "value"
  # default     = "Value"

  validation {
    condition = !can(regex("[[:upper:]]", var.test_lowercase_string))
    error_message = "IThere is an upperase letter in string"
  }
}

variable "check" {
  description="Who is better Connor or Duncan?"
  type = object({
      Dunkan = optional(bool)
      Connor = optional(bool)
  })

  default = {
      Dunkan = true
      Connor = false
  }

  validation {
      error_message = "There can be only one MacLeod"
      condition = (var.check.Dunkan || var.check.Connor) && !(var.check.Dunkan && var.check.Connor)
  }
}