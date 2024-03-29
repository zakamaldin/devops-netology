## Задача 1

Опишите кратко, в чём основное отличие полной (аппаратной) виртуализации, паравиртуализации и виртуализации на основе ОС.

### Ответ:

- Полная виртуализация: нет хостовой ОС, гипервизор распределяет ресурсы процессора напрямую.
- Паравиртуализация: несколько гостевых ОС на хостовой, разделение ресурсов хостовой ОС проиходит гипервизором, установленным на хостовую ОС, также необходимо изменить ядра гостевой системы, в отличие от полной виртуализации.
- Виртуализация уровня ОС: есть хостовая ОС, гостевые должны быть основа на ядре того, же типа,что и хостовая ОС. Распределением ресурсов занимается ядро хостовой ОС.

## Задача 2

Выберите один из вариантов использования организации физических серверов в зависимости от условий использования.

Организация серверов:

- физические сервера,
- паравиртуализация,
- виртуализация уровня ОС.

Условия использования:

- высоконагруженная база данных, чувствительная к отказу;
- различные web-приложения;
- Windows-системы для использования бухгалтерским отделом;
- системы, выполняющие высокопроизводительные расчёты на GPU.

Опишите, почему вы выбрали к каждому целевому использованию такую организацию.

### Ответ:

- физические сервера:
  - Windows-системы для использования бухгалтерским отделом: так как бухгалтерии требуется специализированный софт + работа с токенами, это все очень плохо дружит с виртуализацией
  - системы, выполняющие высокопроизводительные расчёты на GPU: не имеет смысла делить ресурсы между виртуальными средами
-  паравиртуализация
  - высоконагруженная база данных, чувствительная к отказу: так как удобно делать снапшоты состояния базы и откатываться на нужные версии
- виртуализация уровня ОС
  - различные web-приложения: легко управлять потребляемыми ресурсами и строить распределенные системы, на одном хосте могут быть десятки взаимосвязанных контейнеров


## Задача 3

Выберите подходящую систему управления виртуализацией для предложенного сценария. Детально опишите ваш выбор.

Сценарии:

1. 100 виртуальных машин на базе Linux и Windows, общие задачи, нет особых требований. Преимущественно Windows based-инфраструктура, требуется реализация программных балансировщиков нагрузки, репликации данных и автоматизированного механизма создания резервных копий.
2. Требуется наиболее производительное бесплатное open source-решение для виртуализации небольшой (20-30 серверов) инфраструктуры на базе Linux и Windows виртуальных машин.
3. Необходимо бесплатное, максимально совместимое и производительное решение для виртуализации Windows-инфраструктуры.
4. Необходимо рабочее окружение для тестирования программного продукта на нескольких дистрибутивах Linux.

### Ответ:

    1. Продукты VMWare(vSphere и ESXi)
        - полностью покроют такую инфраструктуру
        - работает "из коробки"
        - высокий уровень безопасности
        - хорошая поддержка
    2.KVM, Xen
        - стабильное решение
        - большой вклад крупных ИТ компаний в развитие
        - простота в управлении(гостевая ОС работает как процесс)
        - возможность импользовать аппаратный режим в Xen
        - есть шаблоны для гостевых ОС
    3.Hyper-v
        - нативное готовое решение от самих Microsoft
        - простая работа с драйверами
        - масштабирование 
        - есть бесплатная версия
        - низкий порог вхождения
        - большой перечень совместимых хостовых ОС
    4.Docker, KVM, LXC, OpenVZ,Xen
        - простое управление
        - известные системы
        - гостевая ОС работает как процесс


## Задача 4

Опишите возможные проблемы и недостатки гетерогенной среды виртуализации (использования нескольких систем управления виртуализацией одновременно) и что необходимо сделать для минимизации этих рисков и проблем. Если бы у вас был выбор, создавали бы вы гетерогенную среду или нет? Мотивируйте ваш ответ примерами.

### Ответ:

    Проблемы в гибридных решениях:
    - разные части инфраструктуры необходимо управлять разными инструментами, а это будет требовать либо более высокой квалификации инженеров, либо расширение штата сотрудников ИТ-отдела
    - недоутилизация физического оборудования в связи с повышением несовместимости, не сможем развернуть нужные виртуальные машине, на свободном оборудовании
    - снижение надежности и отказоусточивости все инфратструктуры, так как есть несколько точек отказа
    - снижение безопасности, разные инструменты требуют разных подходов вопросу безопасности

    Из выбираемых решений - все зависит от мощностей которыми мы располагаем и целями, которыми хотим их нагружать

    - VMware: стандарт, простой и понятный, но дорого
    - openstack: интересная платформа с котрой хотелось бы поиграть, но сложно настравивать и поддерживать
    - Hyper-v: понятный нативный инструмент от Microsoft, но требует лицензии на каждую ОС + навики администрирования windows
