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
- `Make vector directory` - выполняет создане директории, куда будет скачан иустановлен пакет vector
- `Download Vector` - выполняет скачивание пакета vector
- `Unarchive package` - выполняет разархивирование(установку) скачанного пакета vector в заданную директорию
- `Configure vector` - выполняет конфигурирование пакета vector

#### Variables

Переменные для play `Install Vector`:
- `vector_version` - указание версию пакета vector, который необходимо скачать и установить
- `vector_install_dir` - указание рабочей директории пакета vector 