# Firewalls

In this module we are going to briefly cover installing and configuring a firewall on our VM. Like our other modules, adding IPv6 support is "easy" - the tools are available and do support IPv6 but they require testing and some planning. The biggest point to take away is that just as you need to lock down/secure access over IPv4 you need to do the same over IPv6.

## iptables / iptables6

`iptables` and it's IPv6 version `ip6tables` allow you to control the traffic to and from (or through) your VM. 

    # sudo yum -y install iptables iptables-ipv6

By default you'll see no rules exist so nothing is blocked, and the default filter is to ACCEPT (allow).

    # sudo /sbin/iptables -L
    # sudo /sbin/ip6tables -L


If there are defined rules you can run `/sbin/iptables -F; /sbin/iptables -X;` to flush and delete the existing rules.

The rules for IPv4 and completely separate from the rules for IPv6 allowing you to create customized rules for either flavour. The difference is entirely which command, and what type of address is being used. `iptables` rule chains are made of INPUTs, OUTPUTs, and FORWARDs.

A couple sample rules to hilight the differences:

  * Blocking the entire IPv6 Address Prefix for Documentation from our VM:

    sudo /sbin/ip6tables -A INPUT -s 2001:DB8::/32 -j DROP

  * Blocking an entire block of IPv4 addresses from our VM:

    sudo /sbin/iptables -A INPUT -s 192.168.253.0/24 -j DROP

  * Block a single I

If we then run `/sbin/ip6tables -L` and `/sbin/iptables -L` we can see the rules.

  * Allowing anyone to SSH in over IPv4 or IPv6

    sudo /sbin/iptables -A INPUT -i eth0  -p tcp -dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
    sudo /sbin/iptables -A OUTPUT -p tcp -sport 22 -m state --state ESTABLISHED -j ACCEPT
    sudo /sbin/ip6tables -A INPUT -i eth0  -p tcp -dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
    sudo /sbin/ip6tables -A OUTPUT -p tcp -sport 22 -m state --state ESTABLISHED -j ACCEPT

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

