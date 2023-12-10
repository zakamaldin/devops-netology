# Ansible. Домашняя работа №2 "Работа с Playbook"

## Описание работы Playbook

Playbook состоит из 2 play:
- Install Clickhouse
- Install Vector


### Clickhouse

#### Tasks

Play `Install Clickhouse` состоит из следующих тасок:
- `Get Clickhouse` - выполняет скачивание серверной и клиентской части
- `Install clickhouse packages` - установка скачанных пакетов и запуск севрерной части, используя хэендлер `Start clickhouse service`
- `Create database` - создание базы в Clickhouse, проверка работсоспособности серверной и клиенской частей

#### Variables

Переменные для play `Install Clickhouse`:
- `clickhouse_version` - указание версии пакетов clickhouse, которые необходимо скачать и установить
- `clickhouse_packages` - список пакетов clickhouse, которые необходимо скачать и установить

### Vector

#### Tasks

Play `Install Vector` состоит из следующих тасок:
- `Make Vector temp directory` - выполняет создане директории, куда будет скачан и извлечен пакет Vector
- `Download Vector` - выполняет скачивание пакета Vector
- `Unarchive package` - выполняет разархивирование(установку) скачанного пакета Vector в заданную директорию
- `Create Vector system user` - выполняет создание системного пользователя `vector` для запуска пакета Vector
- `Install Vector` - копирут исполняемый файл пакета Vector в директорию /usr/bin
- `Make Vector data directory` - выполняет создание директории, где будут храниться данные пакета Vector
- `Make Vector config directory` - выполняет создание директории, где будет храниться конфигурация пакета Vector
- `Configure Vector` - выполняет конфигурирование пакета Vector
- `Create Vector service` - выполняет создание сервиса в systemd
- `Reload Daemon` - выполняет перезаупск службы демона systemd, для дальнейшего запуска пакета Vector через хэндлер `Start Vector service`

#### Variables

Переменные для play `Install Vector`:
- `vector_version` - указание версию пакета vector, который необходимо скачать и установить