#!/bin/bash
sudo mkfs -t ext4 /dev/xvdf
sudo mount /dev/xvdf /var/log
sudo sed 's/PasswordAuthentication no/PasswordAuthentication yes/' -i /etc/ssh/sshd_config
sudo service sshd restart
sudo useradd -m -s /bin/bash "siemens"
echo "siemens:siemens" | sudo chpasswd
sudo chown -R "siemens:siemens" "/home/siemens"
sudo chmod 700 "/home/siemens"
sudo apt update -y
sudo apt install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible -y
sudo apt install ansible -y
git clone https://github.com/kumard0303/ansible_repo.git /home/siemens/ansible_repo
sudo ansible-playbook -i inventory_file /home/siemens/ansible_repo/nginx/nginx_setup.yml
sudo ansible-playbook -i inventory_file /home/siemens/ansible_repo/cloudwatch/cloudwatch.yml
sudo openssl req -x509 -newkey rsa:4096 -sha256 -days 3650   -nodes -keyout example.com.key -out example.com.crt -subj "/CN=example.com"   -addext "subjectAltName=DNS:example.com,DNS:*.example.com,IP:$(hostname -i)"
sudo mv example.com.key example.com.crt /etc/ssl/
sudo mv /home/siemens/ansible_repo/html/index.html /var/www/html/index.html
sudo systemctl restart nginx

