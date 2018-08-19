# zombrox_infra
zombrox Infra repository

Homework #10

Что сделано :
- созданы 2 роли для развертывания инстансов с приложением и БД
- описаны 2 окружения prod и stage
- использована комюнити роль jdauphant.nginx для настройки proxy pass на app инстансах

Как запустить проект:

- для развертывания prod окружения запустить: ansible-playbook -i environments/prod/inventory playbooks/site.yml
- для развертывания stage окружения запустить: ansible-playbook playbooks/site.yml

Как проверить работоспособность:

- В адресной строке браузера перейти на http://ip-address-of-app

#######################################################################################

Homework #9

Что сделано :
- Написан плейбук с одним сценарием для настройки инстансов с mongodb и приложением, разделенный при помощи тегов
- Написан шаблон когфига для mongodb
- Написан EnvironmentFile содержащий парамтр для подключения к BD
- Ранее написаный плейбук разбит на отдельные сценарии
- На основе плейбука с разделенными сценариями написаны 3 раздельных плейбука
- Написан плейбук объединяющий 3 ранее написанных раздельных плейбука
- Написаны плейбуки для провижена в Packer

Как запустить проект:

- Создание базового образа для приложения: packer build -var-file=packer/variables.json packer/app.json
- Создание базового образа для БД : packer build -var-file=packer/variables.json packer/db.json

- Установка БД и приложения одним плейбуком: ansible-playbook site.yml

- Установка приложения плейбуком с единым сценарием: ansible-playbook reddit_app_one_play.yml --limit app --tags app-tag
- Установка БД плейбуком с единым сценарием: ansible-playbook reddit_app_one_play.yml --limit db --tags db-tag
- Деплой плейбуком с единым сценарием: ansible-playbook reddit_app_one_play.yml --limit app --tags deploy-tag

- Установка приложения плейбуком с раздельными сценариями: ansible-playbook reddit_app_multiple_plays.yml --tags app-tag
- Установка БД плейбуком с раздельными сценариями: ansible-playbook reddit_app_multiple_plays.yml --tags db-tag
- Деплой плейбуком с раздельными сценариями: ansible-playbook reddit_app_multiple_plays.yml --tags deploy-tag

Как проверить работоспособность:
- В адресной строке браузера перейти на http://ip-address-of-app:9292


#######################################################################################

Homework #8

Что сделано :
- Установлен Ansible
- Создан inventory файл в формате INI
- Создан конфигурационный файл ansible.cfg содержащий занчения по умолчанию
- Inventory файл разделен на группы
- Создан inventory файл в формате YAML
- Опробованы в работе различные модули (ping, command, shell, git, systemd, service)
- Написан Playbook для клонирования git репозитория.

-- При запуске плейбука после выполнения команды 'rm -rf ~/reddit' изменилось занчение  changed с 0 на 1
Это произошло так как команда 'rm -rf ~/reddit' удалила папку reddit. При предшествующем выполнении плейбука changed=0 т.к. фактических именений не происходило поскольку ранее мы уже клонировали репозиторий при использовании модулей git и command, но не удаляли его после этого.



Как проверить работоспособность:
Выполнить ansible-playbook clone.yml в ansible/


########################################################################################

Homework #7
Что сделано :
- Определен ресурс правила фаервола;
- Произведен импорт существуещего правила фаервола в state;
- Определен ресурс для выделения постоянного внешнего IP адреса;
- Описаны шаблоны Packer для создания 2х базовых образов. Один с установленной MongoDB, а другой с установленным Ruby
- Отдельными файлами определены кофигурации 2х виртуальных машин с разнесеными Ruby и MongoDB, а таже правилом фаервола.
- Указанная выше инфраструктура переопределены в виде модулей.
- На базе модулей созданы окружения Stage и Prod
- Подключен внешний модуль storage-bucket с использованием которого созданы 2 бакета.

Как запустить проект:
 - Запустить terraform apply в terraform/stage/ для создания stage окружения
 - Запустить terraform apply в terraform/prod/ для создания prod окружения
 - Запустить terraform apply в terraform/ для создания бакетов

Как проверить работоспособность:
 - Убедится в создании ресурсов в веб панели CGP,  а также зайти на созданные истансы при помощи ssh и убедится, что установленны необходимые пакеты.


##########################################################################################

Homework #6

Что сделано :
 Основное задание:
 - Удален SSH ключ из метаданных проекта в CGP
 - Устанвлен Terraform
 - написан файл main.tf с описанием  провайдера и процесса создания истанса на основе базового образа, а также добавления правила firewall
 - создан файл outputs.tf c описанием выходных переменных (IP адреса созданного на основе описания инстанса)
 - создан файл variables.tf с описанием входных переменных
 - Произведена финальная проверка создания инстанса с запущенным приложением посредством запуска команд terrform destroy и terraform apply

 Задание со *:
 - в main.tf описано добавление в метаданные проекта SSH ключа пользователя appuser1, а затем пользователей appuser2 и appuser3
 - в web интерфейсе CGP добавленн SSH ключ для пользователя appuser_web. После выполнения terraform apply он пропал :)

 Задание с **:
 - Создан файл lb.tf с описанием процесса создания балансировщика распределяющего запросы по инстансам в группе
 - в main.tf добавлен параметр count для одновременного создания нескольких одинаковых инстансов
 - в variables.tf добавленна соотвествующая параметру count переменная
 - в outputs.tf добавленна переменная для получения IP адреса баласировщика, а таже изменена переменная для получения IP адреса инстанса 
так, что бы получался массив из IP адресов всех созданных инстансов.
 - проверена работоспособность сервиса при остановке работы приложения на одном из истансов



###########################################################################################

Homework #5

Что сделанно: 

- Установлен Packer
- Создан шаблон для создания базового образа из Ububntu 16.04 c установленными Ruby и MongoDB
- Создан отдельный файл с переменными
- Создан шаблон для создания образа с установленным приложением на основе ранее созданного базового образа
- Создан скрипт для создания посредством gcloud виртуальной машины из образа с установленным приложением

Для использования надо:

- Выполнить в директории packer команду packer build -var-file=variables.json ubuntu16.json - для создания базового образа
- Выполнить в директории packer команду packer build -var-file=immutable_var.json immutable.json - для создания образра с приложением
- Запустить в директории config-scripts скрипт create-reddit-vm.sh для создания виртуальной машины на основе полного образа




###########################################################################################

testapp_IP=35.189.210.104
testapp_port=9292

############################################################################################
# startUp script content... :)
 
#!/bin/bash
git clone --branch cloud-testapp https://github.com/Otus-DevOps-2018-05/zombrox_infra.git
cd zombrox_infra
./install_ruby.sh 
./install_mongodb.sh
./deploy.sh 

############################################################################################

# gCloud command that create instance with local file startUp script
gcloud compute instances create reddit-app\
 --boot-disk-size=10GB \
 --image-family ubuntu-1604-lts \
 --image-project=ubuntu-os-cloud \
 --machine-type=g1-small \
 --tags puma-server \
 --restart-on-failure \
 --zone europe-west1-d \
 --metadata-from-file startup-script=startUp.sh

# gCloud command that create instance with URL file startUp script
gcloud compute instances create reddit-app\
 --boot-disk-size=10GB \
 --image-family ubuntu-1604-lts \
 --image-project=ubuntu-os-cloud \
 --machine-type=g1-small \
 --tags puma-server \
 --restart-on-failure \
 --zone europe-west1-d \
 --metadata startup-script-url=gs://zombrox_infra/startUp.sh

# gCloud command that create fireWall rule
gcloud compute firewall-rules create puma-server\
 --direction=in \
 --action=allow \
 --target-tags=puma-server \
 --source-ranges=0.0.0.0/0 \
 --rules=tcp:9292  
