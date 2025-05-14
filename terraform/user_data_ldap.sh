#!/bin/bash
sudo apt update -y
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update -y
sudo apt install docker-ce docker-ce-cli containerd.io -y

sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo systemctl enable docker
sudo systemctl start docker

cd /home/admin

touch Dockerfile

echo -e "
FROM bitnami/openldap:latest
ENV LDAP_ADMIN_USERNAME="admin"
#ENV LDAP_ADMIN_PASSWORD="admin"
ENV LDAP_USERS="maria,juan"
ENV LDAP_PASSWORDS="maria,juan"
EXPOSE 389 
EXPOSE 636 
EXPOSE 1389 
EXPOSE 1636" | sudo tee -a Dockerfile > /dev/null


sudo docker build -t openldap-img .
sudo docker run -d --name openldap -p 389:389 -p 636:636 -p 1389:1389 -p 1636:1636 -e LDAP_ADMIN_PASSWORD="admin" openldap-img