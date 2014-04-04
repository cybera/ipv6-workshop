#! /bin/bash

sudo rpm -Uvh http://nginx.org/packages/rhel/5/x86_64/RPMS/nginx-1.4.7-1.el5.ngx.x86_64.rpm

sudo cp -r /home/v6guru/ipv6-workshop-master/webfiles/*nginx.conf /etc/nginx/conf.d/
sudo rm /etc/nginx/conf.d/default.conf
sudo mkdir -p /usr/share/nginx/html/ipv4
sudo mkdir -p /usr/share/nginx/html/ipv6
sudo cp /home/v6guru/ipv6-workshop-master/webfiles/ipv4.html /usr/share/nginx/html/ipv4/index.html
sudo cp /home/v6guru/ipv6-workshop-master/webfiles/ipv6.html /usr/share/nginx/html/ipv6/index.html
sudo cp /home/v6guru/ipv6-workshop-master/webfiles/www.html /usr/share/nginx/html/index.html

sudo sed -i '1inameserver 127.0.0.1' /etc/resolv.conf

sudo /etc/init.d/nginx restart

sudo /etc/init.d/nginx stop

sudo yum -y install httpd

sudo cp -r /home/v6guru/ipv6-workshop-master/webfiles/*apache.conf /etc/httpd/conf.d/

source /home/v6guru/ipv6-workshop-master/scripts/setIPs.sh

sudo echo 'NameVirtualHost *:80' >> /etc/httpd/conf/httpd.conf

sudo /etc/init.d/httpd start

curl -4 http://www.example.com; curl -6 http://www.example.com; curl http://ipv4.example.com; curl http://ipv6.example.com; curl -6 http://ipv4.example.com

