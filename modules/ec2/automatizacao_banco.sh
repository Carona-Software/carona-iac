#! /bin/bash

sudo apt update
sleep 10
sudo apt update
sleep 10

sudo apt install docker.io -y

sudo systemctl start docker

sudo docker pull kauaqt/db-carona:1
sleep 10

sudo docker run --name container-mysql -e MYSQL_ROOT_PASSWORD=rootpassword -e MYSQL_DATABASE=carona -e MYSQL_USER=carona -e MYSQL_PASSWORD=userpassword -p 3306:3306 kauaqt/db-carona:1