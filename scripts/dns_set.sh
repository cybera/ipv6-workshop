#! /bin/bash

# This script doesn't do the reverse DNS

#Set IP addresses.
source /home/v6guru/ipv6-workshop-master/scripts/setIPs.sh

# Install bind and config files
sudo yum -y install bind
sudo cp /usr/share/doc/bind-9.3.6/sample/etc/* /var/named/chroot/etc
sudo cp -r /usr/share/doc/bind-9.3.6/sample/var/named/* /var/named/chroot/var/named/
sudo cp /home/v6guru/ipv6-workshop-master/dnsfiles/named.conf /var/named/chroot/etc/named.conf
sudo cp /home/v6guru/ipv6-workshop-master/dnsfiles/*zone* /var/named/chroot/var/named/

# Add DNS Records to the zone files..

sudo sed -i "s/10.0.1.5/$IP4_WKSHP/" /var/named/chroot/var/named/example.zone.db
sudo sed -i "s/2607:f8f0:690:00x0::5/$IP6_WKSHP/" /var/named/chroot/var/named/example.zone.db

echo "ipv4 IN A $IP4_WKSHP" >> /var/named/chroot/var/named/example.zone.db
echo "ipv6 IN AAAA $IP6_WKSHP" >> /var/named/chroot/var/named/example.zone.db
echo "dual IN A $IP4_WKSHP" >> /var/named/chroot/var/named/example.zone.db
echo "dual IN AAAA $IP6_WKSHP" >> /var/named/chroot/var/named/example.zone.db

# Restart

/etc/init.d/named restart
