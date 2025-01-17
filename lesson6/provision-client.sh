#!/bin/bash
# Генерация SSH-ключа для пользователя vagrant, если он ещё не создан
if [ ! -f /home/vagrant/.ssh/id_rsa ]; then
  ssh-keygen -t rsa -f /home/vagrant/.ssh/id_rsa -q -N ""
fi

mkdir -p /home/vagrant/.ssh
chown -R vagrant:vagrant /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh

apt-get update
apt-get install -y sshpass

sshpass -p "vagrant" ssh-copy-id -i /home/vagrant/.ssh/id_rsa.pub -o StrictHostKeyChecking=no vagrant@192.168.24.2