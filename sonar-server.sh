#!/bin/bash

apt update -y
apt install -y docker.io 

systemctl enable docker
systemctl start docker

docker run -d -p 9000:9000 --name sonar-server sonarqube:latest