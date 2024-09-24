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

sudo cat <<EOF > /etc/hosts
127.0.0.1 localhost
10.0.101.8 control.example.com control
10.0.101.116 node1.example.com node1
10.0.101.130 node2.example.com node2
EOF

sudo apt-get update -y
sudo apt-get update -y
sudo apt-get install -y python3 python3-pip
sudo apt-get install -y ansible

git clone https://github.com/jdvalencit/epam-practical-task.git