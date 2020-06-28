#!/usr/bin/env bash

# TODO(evg): rename to jenkins_master.sh

# Wait proper init
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
sleep 1
done

# Install Java
sudo apt-get update
sudo apt install -y openjdk-8-jre

# Install Jenkins
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install -y jenkins
