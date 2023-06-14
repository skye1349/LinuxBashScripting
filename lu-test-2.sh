#!/bin/bash
set -e

# create a user and set a complex password
read -p 'Enter the username: ' username
read -s -p 'Enter a complex password: ' password
useradd "$username" && echo "User $username has been added successfully."
echo "$password" | passwd --stdin "$username" && echo "Password for $username has been set successfully."

# Install Apache and PHP
dnf -y install httpd php && echo "Apache and PHP have been installed successfully."

# Start and enable apache at boot
systemctl start httpd && echo "Apache has been started successfully."
systemctl enable httpd && echo "Apache has been set to start on boot."

# Write a PHP script that can be viewed by putting the servers IP address into a web browser
echo "<?php
      echo 'Last name: Lu<br/>';
      date_default_timezone_set('Australia/Sydney');
      echo 'AEST date/time: '.date('Y-m-d H:i:s').'<br/>';
      date_default_timezone_set('Europe/Paris');
      echo 'CEST date/time: '.date('Y-m-d H:i:s');
?>" > /var/www/html/index.php && echo "PHP script has been written successfully."

# # Add 4GB of swap space
if [ -f /swapfile ]; then
    swapoff /swapfile
    echo "/swapfile exists, removing and recreating it."
    rm /swapfile
else
    echo "/swapfile doesn't exist, creating a new one."
fi
fallocate -l 4G /swapfile
chmod 600 /swapfile
mkswap /swapfile && echo "Swap space has been created successfully."
swapon /swapfile
echo '/swapfile swap swap defaults 0 0' >> /etc/fstab && echo "Swap space has been set to persist on reboot."


# # Disable selinux
setenforce 0 && echo "SELinux has been disabled successfully."
sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config && echo "SELinux has been set to remain disabled on reboot."

# add http in filewall list
firewall-cmd --permanent --zone=public --add-service=http && echo "HTTP has been added to firewall services list."
firewall-cmd --reload && echo "Firewall rules have been reloaded."

# Restart Apache to make the PHP file take effect
systemctl restart httpd && echo "Apache has been restarted successfully."
