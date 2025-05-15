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
mkdir certs

curl -O https://tomcat.apache.org/tomcat-6.0-doc/appdev/sample/sample.war
sudo curl -L -o httpd.conf https://github.com/JoseManuel134975/LDAP-contra-el-mundo/raw/main/conf/httpd.conf
sudo curl -L -o certs/ca.cer https://github.com/JoseManuel134975/LDAP-contra-el-mundo/raw/main/certs/ca.cer
sudo curl -L -o certs/joseapache.work.gd.cer https://github.com/JoseManuel134975/LDAP-contra-el-mundo/raw/main/certs/joseapache.work.gd.cer
sudo curl -L -o certs/joseapache.work.gd.key https://github.com/JoseManuel134975/LDAP-contra-el-mundo/raw/main/certs/joseapache.work.gd.key
sudo curl -L -o ec2-instance.pem https://github.com/JoseManuel134975/LDAP-contra-el-mundo/raw/main/certs/ec2-instance.pem

touch docker-compose.yml

echo -e "
services:      
  apache:
    image: httpd:latest
    container_name: apache
    ports:
      - 80:80
      - 443:443
    volumes:
      - /home/admin/httpd.conf:/usr/local/apache2/conf/httpd.conf
      - /home/admin/certs/ca.cer:/usr/local/apache2/conf/ca.cer
      - /home/admin/certs/joseapache.work.gd.cer:/usr/local/apache2/conf/joseapache.work.gd.cer
      - /home/admin/certs/joseapache.work.gd.key:/usr/local/apache2/conf/joseapache.work.gd.key
#      - /home/admin/httpd-vhosts.conf:/usr/local/apache2/conf/extra/httpd-vhosts.conf

  tomcat:
    image: tomcat:latest
    container_name: tomcat
    ports:
      - 9090:9090
    volumes:
      - /home/admin/sample.war:/usr/local/tomcat/webapps/sample.war" | sudo tee -a docker-compose.yml > /dev/null


sudo docker-compose up -d