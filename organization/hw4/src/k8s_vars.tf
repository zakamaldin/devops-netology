
variable "k8s_cluster_metadata" {
  type = object({
    name             = string
    resource_sa_name = string
    hosts_sa_name    = string
    version          = string
    public_ip        = bool
    auto_upgrade     = bool
    release_channel  = string
    region           = string
    })

    default = {
        name             = "k8s-netology-cluster"
        resource_sa_name = "netology-k8s-resource-sa"
        hosts_sa_name    = "netology-k8s-hosts-sa"
        version          = "1.27"
        public_ip        = true
        auto_upgrade     = false
        release_channel  = "STABLE"
        region           = "ru-central1"
    }
    description = "Default resources of k8s cluster"
}


variable "k8s_cluster_node_group_metadata" {
  type = object({
    name               = string
    version            = string
    platform_id        = string
    nat                = bool
    memory             = number
    cores              = number
    disk_type          = string
    disk_size          = number
    preemptible        = bool
    runtime_type       = string
    auto_scale_min     = number
    auto_scale_max     = number
    auto_scale_initial = number
    })

    default = {
        name               = "netology-k8s-node-group"
        version            = "1.27"
        platform_id        = "standard-v2"
        nat                = false
        memory             = 2
        cores              = 2
        disk_type          = "network-hdd"
        disk_size          = 64
        preemptible        = true
        runtime_type       = "containerd"
        auto_scale_min     = 3
        auto_scale_max     = 6
        auto_scale_initial = 3
    }
    description = "Default resources of k8s cluster"
}