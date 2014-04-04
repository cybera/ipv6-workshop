# Firewalls

In this module we are going to install and configure a firewall on our VM. Like our other modules, adding IPv6 support is "easy" - the tools are available and do support IPv6 but they require testing and some planning.

## iptables / iptables6

`iptables` and it's IPv6 version `ip6tables` allow you to control the traffic to and from (or through) your VM. 

    # sudo yum -y install iptables iptables-ipv6

By default you'll see no rules exist so nothing is blocked.

    # sudo /sbin/iptables -L
    # sudo /sbin/ip6tables -L


## ufw

`ufw` (Uncomplicated Firewall) is another popular firewall with much nicer syntax. It also support IPv4 and IPv6.

For an example you can see the rule stolen directly from a [speedtest](http://speedtest.cybera.ca) server I help manage.

    #!/bin/sh

    sudo ufw allow 80;
    sudo ufw allow 8080;
    sudo ufw allow 5060;
    sudo ufw allow proto tcp from 134.87.113.74/24 to any port 22;
    sudo ufw allow proto tcp from 2607:f8f0:690:31:5652:ff:fe70:f505/64 to any port 22;
    sudo ufw allow proto tcp from 134.87.113.74/24 to any port 5666;
    sudo ufw allow proto tcp from 2607:f8f0:690:31:5652:ff:fe70:f505/64 to any port 5666;

