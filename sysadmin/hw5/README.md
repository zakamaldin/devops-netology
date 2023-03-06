# Домашнее задание к занятию «Файловые системы»

## Задание

1. Узнайте о [sparse-файлах](https://ru.wikipedia.org/wiki/%D0%A0%D0%B0%D0%B7%D1%80%D0%B5%D0%B6%D1%91%D0%BD%D0%BD%D1%8B%D0%B9_%D1%84%D0%B0%D0%B9%D0%BB) (разряженных).

    ### Ответ:

    Разреженные файлы - способ представления файлов в ФС, в которых не записываются нулевые байты, а лишь информация об их последоавтельности,что помогает уменьшить физический размер файла на диске, но добавляет накладные расходы на работы последовательностями.

2. Могут ли файлы, являющиеся жёсткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?
    
    ### Ответ:

    Нет, так как жесткая ссылка имеет тот же индексный дескриптор (inode), поэтому жесткая ссылка имеет те же права доступа, валедльца и  что и оригинальный файл



3. Сделайте `vagrant destroy` на имеющийся инстанс Ubuntu. Замените содержимое Vagrantfile следующим:

    ```ruby
    path_to_disk_folder = './disks'

    host_params = {
        'disk_size' => 2560,
        'disks'=>[1, 2],
        'cpus'=>2,
        'memory'=>2048,
        'hostname'=>'sysadm-fs',
        'vm_name'=>'sysadm-fs'
    }
    Vagrant.configure("2") do |config|
        config.vm.box = "bento/ubuntu-20.04"
        config.vm.hostname=host_params['hostname']
        config.vm.provider :virtualbox do |v|

            v.name=host_params['vm_name']
            v.cpus=host_params['cpus']
            v.memory=host_params['memory']

            host_params['disks'].each do |disk|
                file_to_disk=path_to_disk_folder+'/disk'+disk.to_s+'.vdi'
                unless File.exist?(file_to_disk)
                    v.customize ['createmedium', '--filename', file_to_disk, '--size', host_params['disk_size']]
                end
                v.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', disk.to_s, '--device', 0, '--type', 'hdd', '--medium', file_to_disk]
            end
        end
        config.vm.network "private_network", type: "dhcp"
    end
    ```

    Эта конфигурация создаст новую виртуальную машину с двумя дополнительными неразмеченными дисками по 2,5 Гб.

    ### Ответ:
    
    ![5_3](images/5_3.png)


4. Используя `fdisk`, разбейте первый диск на два раздела: 2 Гб и оставшееся пространство.

    ### Ответ:
    
    ![5_4](images/5_4.png)

5. Используя `sfdisk`, перенесите эту таблицу разделов на второй диск.

    ### Ответ:
    
    ![5_5](images/5_5.png)

6. Соберите `mdadm` RAID1 на паре разделов 2 Гб.

    ### Ответ:
    
    ![5_6](images/5_6.png)

7. Соберите `mdadm` RAID0 на второй паре маленьких разделов.

    ### Ответ:
    
    ![5_7](images/5_7.png)

8. Создайте два независимых PV на получившихся md-устройствах.

    ### Ответ:
    
    ![5_8](images/5_8.png)

9. Создайте общую volume-group на этих двух PV.

    ### Ответ:
    
    ![5_9](images/5_9.png)

10. Создайте LV размером 100 Мб, указав его расположение на PV с RAID0.

    ### Ответ:
    
    ![5_10](images/5_10.png)

11. Создайте `mkfs.ext4` ФС на получившемся LV.

    ### Ответ:
    
    ![5_11](images/5_11.png)

12. Смонтируйте этот раздел в любую директорию, например, `/tmp/new`.

    ### Ответ:
    
    ![5_12](images/5_12.png)

13. Поместите туда тестовый файл, например, `wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz`.

    ### Ответ:
    
    ![5_13](images/5_13.png)

14. Прикрепите вывод `lsblk`.

    ### Ответ:
    
    ![5_14](images/5_14.png)

15. Протестируйте целостность файла:

    ```bash
    root@vagrant:~# gzip -t /tmp/new/test.gz
    root@vagrant:~# echo $?
    0
    ```

    ### Ответ:
    
    ![5_15](images/5_15.png)

16. Используя pvmove, переместите содержимое PV с RAID0 на RAID1.

    ### Ответ:
    
    ![5_16](images/5_16.png)

17. Сделайте `--fail` на устройство в вашем RAID1 md.

    ### Ответ:
    
    ![5_17](images/5_17.png)

18. Подтвердите выводом `dmesg`, что RAID1 работает в деградированном состоянии.

    ### Ответ:
    
    ![5_18](images/5_18.png)

19. Протестируйте целостность файла — он должен быть доступен несмотря на «сбойный» диск:

    ```bash
    root@vagrant:~# gzip -t /tmp/new/test.gz
    root@vagrant:~# echo $?
    0
    ```

    ### Ответ:
    
    ![5_19](images/5_19.png)

20. Погасите тестовый хост — `vagrant destroy`.

    ### Ответ:
    
    ![5_20](images/5_20.png)
