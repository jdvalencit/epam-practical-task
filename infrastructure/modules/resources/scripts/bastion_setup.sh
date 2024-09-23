#!/bin/bash

sudo bash -c 'cat <<EOF > ~/home/ubuntu/.ssh/config
Host node*
  StrictHostKeyChecking no
  UserKnownHostsFile /dev/null
  User ubuntu
  IdentityFile /home/ubuntu/final_task/ansible.pem
EOF'

sudo apt-get update -y
sudo apt-get update -y
sudo apt-get install -y python3 python3-pip
sudo apt-get install -y ansible
sudo ansible-galaxy collection install community.general -y

chmod 600 ~/.ssh/config