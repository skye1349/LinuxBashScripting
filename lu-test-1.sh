#!/bin/bash

# create a user and set a complex password
read -p 'Enter the username: ' username
read -s -p 'Enter a complex password: ' password
useradd "$username"
echo "$password" | passwd --stdin "$username"

# Install Apache and PHP
dnf -y install httpd php

# Start and enable apache at boot
systemctl start httpd
systemctl enable httpd

# Write a PHP script that can be viewed by putting the servers IP address into a web browser
echo "<?php
      echo 'Last name: Lu<br/>';
      date_default_timezone_set('Australia/Sydney');
      echo 'AEST date/time: '.date('Y-m-d H:i:s').'<br/>';
      date_default_timezone_set('Europe/Paris');
      echo 'CEST date/time: '.date('Y-m-d H:i:s');
?>" > /var/www/html/index.php

# Add 4GB of swap space
swapoff /swapfile
rm /swapfile
fallocate -l 4G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile swap swap defaults 0 0' >> /etc/fstab

# Disable selinux
setenforce 0
sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config

# add http in filewall list
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --reload

# Restart Apache to make the PHP file take effect
systemctl restart httpd