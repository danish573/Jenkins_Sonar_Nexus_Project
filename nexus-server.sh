#!/bin/bash

apt update -y
apt install -y docker.io 

systemctl enable docker
systemctl start docker

docker run -d -p 8081:8081 --name nexus-server sonatype/nexus3