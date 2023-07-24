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

###vm_db vars

variable "vm_db_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "OS image family for DB VM"
}

variable "vm_db_instanse_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "Name of DB VM in Cloud"
}

variable "vm_db_instanse_username" {
  type        = string
  default     = "ubuntu"
  description = "Name of username in DB VM"
}

variable "vm_db_instanse_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Id of CPU platform in Cloud"
}

variable "vm_db_instanse_cores" {
  type        = number
  default     = 2
  description = "Number of CPU in DB VM"
}

variable "vm_db_instanse_memory" {
  type        = number
  default     = 2
  description = "Number of RAM in DB VM(GB)"
}

variable "vm_db_instanse_core_fraction" {
  type        = number
  default     = 20
  description = "Percent of CPU performance in DB VM"
}

variable "vm_db_instanse_scheduling_policy_preemptible" {
  type        = bool
  default     = true
  description = "Make DB VM an interruptible"
}

variable "vm_db_instanse_network_interface_nat" {
  type        = bool
  default     = true
  description = "Enable NAT for DB VM"
}

variable "vm_db_instanse_metadata_serial_port_enable" {
  type        = number
  default     = 1
  description = "Enable serial-port to DB VM from Cloud UI"
}