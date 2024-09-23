#!/bin/bash

mkdir -p ~/.ssh

cat <<EOL > ~/.ssh/config
Host node*
  StrictHostKeyChecking no
  UserKnownHostsFile /dev/null
  User ubuntu
  IdentityFile /home/ubuntu/ansible.pem
EOL

chmod 600 ~/.ssh/config

sudo apt-get update -y
sudo apt-get update -y
sudo apt-get install -y python3 python3-pip
sudo apt-get install -y ansible

git clone https://github.com/jdvalencit/epam-practical-task.git