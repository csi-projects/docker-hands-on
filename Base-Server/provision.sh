# Provision file for the base VM
sudo apt-get update

# Docker installation
sudo apt-get install -y curl nano locate; curl -s https://get.docker.io/ubuntu/ | sudo sh

# Docker mysql : https://registry.hub.docker.com/_/mysql/
sudo docker pull mysql
sudo apt-get install -y mysql-client-core-5.5

# Docker ubuntu:14.04
sudo docker pull ubuntu:14.04

# Docker HAProxy
sudo docker pull dockerfile/haproxy
