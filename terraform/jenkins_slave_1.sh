#!/usr/bin/env bash

# Wait proper init
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
sleep 1
done

# Install Java
sudo apt-get update
sudo apt install -y openjdk-8-jre
which java
curl https://ipinfo.io/ip
