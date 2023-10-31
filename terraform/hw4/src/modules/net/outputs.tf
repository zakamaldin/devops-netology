output "network_id" {
    description = "Network id from 'net' module"
    value       = yandex_vpc_network.net.id
}

output "subnet_ids" {
    description = "Subnet id from 'net' module"
    value       = [ for subnet in yandex_vpc_subnet.net : subnet.id ] 
}