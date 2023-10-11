output "network_id" {
    description = "Network id from 'net' module"
    value       = yandex_vpc_network.net.id
}

output "subnet_id" {
    description = "Subnet id from 'net' module"
    value       = yandex_vpc_subnet.net.id
}