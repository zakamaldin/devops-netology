# Домашнее задание к занятию «Командная оболочка Bash: Практические навыки»

## Задание 1

Есть скрипт:

```bash
a=1
b=2
c=a+b
d=$a+$b
e=$(($a+$b))
```

Какие значения переменным c, d, e будут присвоены? Почему?

| Переменная  | Значение | Обоснование |
| ------------- | ------------- | ------------- |
| `c`  | a+b  | Запись строки `a+b` в переменную `c`, так как нет вывода значений переменных `a` и `b`|
| `d`  | 1+2  | Запись строки `1+2` в переменную `d`, так есть взятие значений переменных `a` и `b` через `$`, однако `bash` не понимает, что нужно произвести сложение двух чисел, поэтому конкатенирует строки `1`, `+`, `2` |
| `e`  | 3  | Есть расширение скобок, которое сообщает оболочке, что нужно именно сложить два числа, взятых из переменных `a` и `b` через `$`, привести результат к целому числу и записать в переменную `e`|

----

## Задание 2

На нашем локальном сервере упал сервис, и мы написали скрипт, который постоянно проверяет его доступность, записывая дату проверок до тех пор, пока сервис не станет доступным. После чего скрипт должен завершиться. 

В скрипте допущена ошибка, из-за которой выполнение не может завершиться, при этом место на жёстком диске постоянно уменьшается. Что необходимо сделать, чтобы его исправить:

```bash
while ((1==1)
do
	curl https://localhost:4757
	if (($? != 0))
	then
		date >> curl.log
	fi
done
```

### Ваш скрипт:

```bash
while ((1==1)
do
	date > curl.log
    curl https://localhost:4757
	if (($? == 0))
	then
        break
	fi
done
```

---

## Задание 3

Необходимо написать скрипт, который проверяет доступность трёх IP: `192.168.0.1`, `173.194.222.113`, `87.250.250.242` по `80` порту и записывает результат в файл `log`. Проверять доступность необходимо пять раз для каждого узла.

### Ваш скрипт:

```bash
hosts=(192.168.0.1:80 173.194.222.113:80 87.250.250.242:80)

while ((1==1))
do
    for host in ${hosts[@]}
    do
        for i in {1..5}
        do
            result=GOOD
            curl -s $host > /dev/null
            if (($? != 0))
                then
                    result=BAD
                fi
            echo $(date) $host $result >> curl.log
        done
    done
done
```

---
## Задание 4

Необходимо дописать скрипт из предыдущего задания так, чтобы он выполнялся до тех пор, пока один из узлов не окажется недоступным. Если любой из узлов недоступен — IP этого узла пишется в файл error, скрипт прерывается.

### Ваш скрипт:

```bash
hosts=(192.168.0.1:80 173.194.222.113:80 87.250.250.242:80)
while ((1==1))
do
    for host in ${hosts[@]}
    do
        for i in {1..5}
        do
            curl -s $host > /dev/null
            if (($? != 0))
                then
                    echo $host > error.log
                    echo "Find BAD host!!!"
                    exit 1
                fi
            echo $(date) $host >> curl.log
        done
    done
done
```
