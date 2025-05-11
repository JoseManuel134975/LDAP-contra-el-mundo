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
curl -O https://tomcat.apache.org/tomcat-6.0-doc/appdev/sample/sample.war
sudo curl -L -o httpd.conf https://github.com/JoseManuel134975/LDAP-contra-el-mundo/raw/main/conf/httpd.conf
sudo curl -L -o httpd-vhosts.conf https://github.com/JoseManuel134975/LDAP-contra-el-mundo/raw/main/conf/httpd-vhosts.conf
sudo curl -L -o server.xml https://github.com/JoseManuel134975/LDAP-contra-el-mundo/raw/main/conf/server.xml
sudo curl -L -o web.xml https://github.com/JoseManuel134975/LDAP-contra-el-mundo/raw/main/conf/web.xml

touch docker-compose.yml

echo -e "version: '2'
services:      
  apache:
    image: httpd:latest
    container_name: apache
    ports:
      - 8080:80
      - 8443:443
    volumes:
      - /home/admin/httpd.conf:/usr/local/apache2/conf/httpd.conf
      - /home/admin/httpd-vhosts.conf:/usr/local/apache2/conf/extra/httpd-vhosts.conf

  tomcat:
    image: tomcat:latest
    container_name: tomcat
    ports:
      - 9090:9090
    volumes:
      - /home/admin/sample.war:/usr/local/tomcat/webapps/sample.war
      - /home/admin/server.xml:/usr/local/tomcat/conf/server.xml
      - /home/admin/web.xml:/usr/local/tomcat/webapps/sample/WEB-INF/web.xml
    depends_on:
      - openldap

  openldap:
    image: bitnami/openldap:latest
    container_name: openldap
    ports:
      - 1389:1389
    environment:
      - LDAP_ADMIN_USERNAME=admin
      - LDAP_ADMIN_PASSWORD=admin123
      - LDAP_USERS=juan,carlos
      - LDAP_PASSWORDS=juan123,carlos123" | sudo tee -a docker-compose.yml > /dev/null


sudo docker-compose up -d