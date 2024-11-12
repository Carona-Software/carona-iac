#!/bin/bash

# Atualiza os pacotes
sudo apt update
sleep 10
sudo apt install docker.io -y
sleep 10

# Inicia o serviço Docker
sudo systemctl start docker

# Baixa a imagem do frontend
sudo docker pull kauaqt/front-carona:v37

# Espera a resolução do DNS
while ! nslookup backend.example.internal; do
    echo "Esperando resolução de backend.example.internal..."
    sleep 5
done

# Aguarda mais um tempo para garantir que o backend está acessível
# sleep 40


# sudo docker run -e REACT_APP_BACKEND_URL="http://${public_ip}/api" -p 80:80 kauaqt/front-carona:v37

# Passa o IP do backend para a variável de ambiente REACT_APP_BACKEND_URL
# sudo docker run --name container-front -e REACT_APP_BACKEND_URL="http://${private_ip}:8080/api" -p 80:80 kauaqt/front-carona:v35