#! /bin/bash

sudo apt update
sleep 10
sudo apt update
sleep 10

sudo apt install docker.io -y
sleep 10

sudo systemctl start docker

sudo docker pull kauaqt/back-carona:v1

sleep 10

sudo docker run --name container-backend -e MYSQL_USER=carona -e MYSQL_PASSWORD=userpassword -e MYSQL_PRIVATE_IP="${private_ip}" -p 8080:8080 kauaqt/back-carona:v1