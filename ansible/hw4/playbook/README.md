# Ansible. Домашняя работа №3 "Работа с Playbook"

## Описание работы Playbook

Playbook состоит из 3 play:
- Install Clickhouse - скачивает и устанавливает пакет ClickHouse с помощью role `clickhouse`
- Install Vector - скачивает и устанавливает сервис Vector с помощью role `vector-role`
- Install LightHouse - скачивает и устанавливает сервис ClickHouse с помощью role `lighthouse-role`