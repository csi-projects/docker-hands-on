#!/bin/bash -v

sudo docker images

# Docker MySQL
# - root / password
# database "handson" with user :
# - handson / handson
sudo docker run --name mysql-handson -e MYSQL_ROOT_PASSWORD=password -e MYSQL_USER=handson -e MYSQL_PASSWORD=handson -e MYSQL_DATABASE=handson -p 3306:3306 -d mysql:5.7

env

pause

sudo docker ps

# Docker tomcat
sudo docker build -t tomcat tomcat

sudo docker images

# Run tomcat with link to mysql
sudo docker run --name tomcat-handson --link mysql-handson:mysql -p 8080:8080 -d tomcat

sudo docker ps

# Create mysql user and database
sleep 5
sudo mysql -h"127.0.0.1" -P"3306" -u"handson" -p"handson" < mysql/mysql-create-database.sql
