# springboot-hello

В данном репозитории описано выполнение тестового задания, в котором необходимо написать Dockerfile, настроить Jenkins, создать две Job (для Docker hub и kubernetes).
Работы были проведены на виртуальном сервере 188.120.228.224 под ОС Ubuntu 20.04 

###Docker установка
```
>apt update
apt install docker docker.io
systemctl enable docker
systemctl start docker
```
###Jenkens установка
```
#настройка разрешающих правил брандмауэра
iptables -I INPUT -p tcp --dport 8080 -j ACCEPT
apt install iptables-persistent
netfilter-persistent save

#установка openjdk
apt install openjdk-11-jre-headless

#добавляем репозиторий сервиса Jenkins
vi /etc/apt/sources.list.d/jenkins.list
	deb https://pkg.jenkins.io/debian-stable binary/

#импортируем актуальный публичный ключ для подключения к репозиторию
wget -q -O - https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key | sudo apt-key add -

#обновляем список пакетов, устанавливаем jenkins, разрешаем автозапуск сервиса
apt update
apt install jenkins
systemctl enable jenkins

#настаиваем jenkins перейдя в браузере по url http://<IP-адрес сервера>:8080 В открывшемся окне в строку вводим код из команды
cat /var/lib/jenkins/secrets/initialAdminPassword
#выбираем вариант установки плагинов — рекомендованные, создаем уз для авторизации
```
###minikube
```
#забираем последний актуальный пакет и устанавливаем его
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb
#проверям версию
minikube version
#для работы так же понадобится kubectl, добавим его ключ, создадим файл с настройкой репозитория, обновим и установим пакет
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt update
sudo apt install -y kubectl
#проверяем версию 
kubectl version
#запускаем minikube, узнаем ip
minikube start --force
minikube ip
```

В репозитории находятся файлы для сборки докеробраза форкнутого приложения (Dockerfile), два pipeline для выполнения job в Jenkens, конфиг файл для k8s (deployment.yaml)



