1. Найдите полный хеш и комментарий коммита, хеш которого начинается на aefea

Полный хэш - aefead2207ef7e2aa5dc81a34aedf0cad4c32545

Комментарий - 'Update CHANGELOG.md'

    $ git log aefea
    commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545
    Author: Alisdair McDiarmid <alisdair@users.noreply.github.com>
    Date:   Thu Jun 18 10:29:58 2020 -0400

        Update CHANGELOG.md

2. Какому тегу соответствует коммит 85024d3?

Тэг - v0.12.23


    $ git log 85024d3 -1
    commit 85024d3100126de36331c6982bfaac02cdab9e76 (tag: v0.12.23)
    Author: tf-release-bot <terraform@hashicorp.com>
    Date:   Thu Mar 5 20:56:10 2020 +0000

        v0.12.23


3. Сколько родителей у коммита b8d720? Напишите их хеши

2 родителя 56cd7859e05c36c06b56d013b55a252d0bb7e158 и 9ea88f22fc6269854151c571162c5bcf958bee2b

Их также можно найти в сообщении коммита так как b8d720 - это merge-commit

    $ git log b8d720 -3 --graph
    *   commit b8d720f8340221f2146e4e4870bf2ee0bc48f2d5
    |\  Merge: 56cd7859e0 9ea88f22fc
    | | Author: Chris Griggs <cgriggs@hashicorp.com>
    | | Date:   Tue Jan 21 17:45:48 2020 -0800
    | |
    | |     Merge pull request #23916 from hashicorp/cgriggs01-stable
    | |
    | |     [Cherrypick] community links
    | |
    | * commit 9ea88f22fc6269854151c571162c5bcf958bee2b
    |/  Author: Chris Griggs <cgriggs@hashicorp.com>
    |   Date:   Tue Jan 21 17:08:06 2020 -0800
    |
    |       add/update community provider listings
    |
    *   commit 56cd7859e05c36c06b56d013b55a252d0bb7e158
    |\  Merge: 58dcac4b79 ffbcf55817
    | | Author: Chris Griggs <cgriggs@hashicorp.com>
    | | Date:   Mon Jan 13 13:19:09 2020 -0800
    | |
    | |     Merge pull request #23857 from hashicorp/cgriggs01-stable
    | |
    | |     [cherry-pick]add checkpoint links

4. Перечислите хеши и комментарии всех коммитов которые были сделаны между тегами v0.12.23 и v0.12.24.

Вывод:

        $ git log v0.12.23~1...v0.12.24 --pretty=oneline
        33ff1c03bb960b332be3af2e333462dde88b279e (tag: v0.12.24) v0.12.24
        b14b74c4939dcab573326f4e3ee2a62e23e12f89 [Website] vmc provider links
        3f235065b9347a758efadc92295b540ee0a5e26e Update CHANGELOG.md
        6ae64e247b332925b872447e9ce869657281c2bf registry: Fix panic when server is unreachable
        5c619ca1baf2e21a155fcdb4c264cc9e24a2a353 website: Remove links to the getting started guide's old location
        06275647e2b53d97d4f0a19a0fec11f6d69820b5 Update CHANGELOG.md
        d5f9411f5108260320064349b757f55c09bc4b80 command: Fix bug when using terraform login on Windows
        4b6d06cc5dcb78af637bbb19c198faff37a066ed Update CHANGELOG.md
        dd01a35078f040ca984cdd349f18d0b67e486c35 Update CHANGELOG.md
        225466bc3e5f35baa5d07197bbc079345b77525e Cleanup after v0.12.23 release
        85024d3100126de36331c6982bfaac02cdab9e76 (tag: v0.12.23) v0.12.23

5. Найдите коммит в котором была создана функция func providerSource, ее определение в коде выглядит так func providerSource(...) (вместо троеточия перечислены аргументы).

Сначала находим в каком файле функция объявлена:

    $ git grep -n -e 'func providerSource('
    provider_source.go:23:func providerSource(configs []*cliconfig.ProviderInstallation, services *disco.Disco) (getproviders.Source, tfdiags.Diagnostics) {

Далее выводим коммиты изменения файла provider_source.go

    $ git log -L :providerSource:provider_source.go

Где мы можем увидеть, что функция func providerSource(...) была создана в коммите
    
    8c928e83589d90a031f811fae52a81be7153e82f

Также есть более корокий, но более долгий вариант:

    $ git log -S 'func providerSource(' --oneline
    8c928e8358 main: Consult local directories as potential mirrors of providers

6. Найдите все коммиты в которых была изменена функция globalPluginDirs.

Находим файл в которой объявлена функция

    $ git grep -n -e 'func globalPluginDirs'
    plugins.go:18:func globalPluginDirs() []string {

Выводим список коммитов:

    $ git log --pretty=oneline -L :globalPluginDirs:plugins.go --no-patch
    78b12205587fe839f10d946ea3fdc06719decb05 Remove config.go and update things using its aliases
    52dbf94834cb970b510f2fba853a5b49ad9b1a46 keep .terraform.d/plugins for discovery
    41ab0aef7a0fe030e84018973a64135b11abcd70 Add missing OS_ARCH dir to global plugin paths
    66ebff90cdfaa6938f26f908c7ebad8d547fea17 move some more plugin search path logic to command
    8364383c359a6b738a436d1b7745ccdce178df47 Push plugin discovery down into command package

7. Кто автор функции synchronizedWriters?

Находим все коммиты с этой функцией:

    $ git log -S 'func synchronizedWriters(' --oneline
    bdfea50cc8 remove unused
    5ac311e2a9 main: synchronize writes to VT100-faker on Windows

И смотрим кто сделал первый коммит(Martin Atkins <mart@degeneration.co.uk>):

    $ git log 5ac311e2a91e381e2f52234668b49ba670aa0fe5 -1
    commit 5ac311e2a91e381e2f52234668b49ba670aa0fe5
    Author: Martin Atkins <mart@degeneration.co.uk>
    Date:   Wed May 3 16:25:41 2017 -0700

        main: synchronize writes to VT100-faker on Windows

        We use a third-party library "colorable" to translate VT100 color
        sequences into Windows console attribute-setting calls when Terraform is
        running on Windows.

        colorable is not concurrency-safe for multiple writes to the same console,
        because it writes to the console one character at a time and so two
        concurrent writers get their characters interleaved, creating unreadable
        garble.

        Here we wrap around it a synchronization mechanism to ensure that there
        can be only one Write call outstanding across both stderr and stdout,
        mimicking the usual behavior we expect (when stderr/stdout are a normal
        file handle) of each Write being completed atomically.


