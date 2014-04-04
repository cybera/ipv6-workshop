# DNS

## DNS and IPv6 support

In order to use IPv6 with DNS, several pieces need to be in place.

  * Underlying OS support (pretty much any OS now)
  * DNS Software support (eg. BIND 9+)
  * TLD supports IPv6 (has/supports IPv6 glue records - most do)

## BIND

We'll be using BIND as our workshop demo program. As the de facto standard on *NIX this is the most common seen DNS authoritative server.

### Installation

    yum install bind*

This installs BIND 9.3.6.

### Record Types and IPv6

The good news is that DNS is incredibly straight forward when it comes to IPv6 - instead of using an A record to define what IPv4 address a hostname has, use a AAAA record instead.

#### A

A records are IPv4 addresses and are not used in an IPv6 only environment.

Eg. `myserver  IN   A   192.168.2.2`

#### AAAA

AAAA records are the IPv6 version of A records.

Eg. `myserver   IN  AAAA    2607:f8f0:690:0010::1`

#### PTR

The record with the most changes is the pointer record. Pointer records which are given in reverse notation (eg. `2.2.168.192.in-addr.arpa`) are for reverse DNS entries.

For IPv6 they follow the same reverse notation seen with IPv4 with a slightly different end domain of `ip6.arpa` instead of `in-addr.arpa`. With the length of IPv6 addresses, using a generator becomes much more recommended. (Look online, use ipv6calc

Eg. `2607:f8f0:690:0010::1`'s PTR record would be `1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.1.0.0.0.9.6.0.0.f.8.f.7.0.6.2.ip6.arpa`

On our VMs you can install [ipv6calc](http://www.deepspace6.net/projects/ipv6calc.html) by doing the following:

    $ wget ftp://ftp.deepspace6.net/pub/ds6/sources/ipv6calc/ipv6calc-0.96.0.tar.gz
    $ tar xzf ipv6calc-0.96.0.tar.gz
    $ cd ipv6calc-0.96.0
    $ ./configure && make
    $ sudo cp ipv6calc/ipv6calc /usr/local/bin

Or use an online tool such as [rDNS6](http://rdns6.com/hostRecord)

(NOTE: Using $ORIGIN in your bind configuration files can save some typing just as it does for IPv4)

#### Other Records

Since all other records (eg. SRV, CNAME, etc.) use hostnames - they "automagically" support any IPv6 calls.

    myserver2                       CNAME   myserver
    _sip_.example.com.    86400   IN  SRV 10  5   5060    sipserver.example.com. 

Some TXT records such as the one used for the Sender Policy Framework (an anti-spam verifcation method) work just as you would hope out the box:

Eg. `example.com.   IN TXT   "v=spf1 a ip4:192.168.2.2 ip6:2607:f8f0:690:0010::1 ~all"`

Translation: Treat any mail that says it's from example.com as valid if it's coming from 192.168.2.2 or 2607:f8f0:690:0010::1 and anything else as suspicious.

### Setting up BIND

Setting up BIND to listen and work over IPv6 is very straight forward. To save time we've created a default named.conf that removes the extraneous portions that we won't use for our demo. The change to note that we made was to add: `listen-on-v6 {any};`. I don't recommend using that value in production unless you're managing DNS traffic via your firewall.

    # cp /usr/share/doc/bind-9.3.6/sample/etc/* /etc
    # cp -r /usr/share/doc/bind-9.3.6/sample/var/named/* /var/named/
    # cp /home/v6guru/ipv6/dnsfiles/named.conf /etc/named.conf
    # cat /etc/named.conf

Next we need to set up our actual zones. We have stubs set up that can be copied in place and edited:

    # cp /home/v6guru/ipv6/dnsfiles/*zone* /var/named/

Edit the zone files to match your subnets. And then we can turn on BIND

    # /etc/init.d/named restart

## Other DNS packages:

The concepts are the same for other DNS packages but the steps may be slightly different for their settings and how their zone file is laid out.

## Exercises

Using BIND 9 - try adding some records to your zone file and use dig on your local computer to make sure they resolve correctly.

On your VM you can use `dig @127.0.0.1 QUERY` or `dig @VM_IP QUERY` on your own laptop to use the client VM as your DNS server.

For doing reverse IP looks up you'll need to do something  similar to specify which DNS server to use to get our "fake" settings instead of the real answer:

    host QUERY CLIENT_VM
    host 2607:f8f0:690:0070::5 CLIENT_VM

For the next section be sure to add:

  * ipv4.example.com with the IPv4 address of your VM
  * ipv6.example.com with the IPv6 address of your VM
  * www.example.com with *both* the IPv4 and IPv6 addresses of your VM
  * Reverse DNS for the above 4 entries.

