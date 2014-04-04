# Web Servers

In this module we are going to install and show how to use IPv6 on a couple web servers.

## nginx

nginx (pronounced Engine-X). Unfortunately the repo with CentOS 5.5 only contains a very old installer, so we need to get the updated package:

    # sudo rpm -Uvh http://nginx.org/packages/rhel/5/x86_64/RPMS/nginx-1.4.7-1.el5.ngx.x86_64.rpm
    
### Basic Configuration

Configuring nginx (or Apache as we'll see later) to listen on IPv6 is extremely easy (so long as the version you have supports IPv6). In this case it's a matter of adding the line `[::]` to your site definitions.

Let's try it out by first copying our site definition files into nginx's configuration directory:

    # sudo cp -r /home/v6guru/ipv6-workshop-master/webfiles/*nginx.conf /etc/nginx/conf.d/
    # sudo rm /etc/nginx/conf.d/default.conf
    # sudo sed -i '1inameserver 127.0.0.1' /etc/resolv.conf
    # sudo ls /etc/nginx/conf.d

Take a look at each of the example files and then copy the sample HTML files into their respective directories.

    # sudo mkdir -p /usr/share/nginx/html/ipv4
    # sudo mkdir -p /usr/share/nginx/html/ipv6
    # sudo cp /home/v6guru/ipv6-workshop-master/webfiles/ipv4.html /usr/share/nginx/html/ipv4/index.html
    # sudo cp /home/v6guru/ipv6-workshop-master/webfiles/ipv6.html /usr/share/nginx/html/ipv6/index.html
    # sudo cp /home/v6guru/ipv6-workshop-master/webfiles/dual.html /usr/share/nginx/html/index.html

Then turn on nginx:

    # sudo /etc/init.d/nginx restart

### Hooking up DNS

On your own computer you can set your DNS server to your workshop VM. Please note that the DNS server we have set up does not pass on requests so it will only work for our example and should be removed after the workshop.

### Testing

On your laptop or on the VM if you have the DNS set up correctly you can see the results by running the following commands (or by visiting the URLs in your browser):

    $ curl http://ipv4.example.com
    $ curl http://ipv6.example.com
    $ curl http://www.example.com
    $ curl -6 http://www.example.com
    $ curl -4 http://www.example.com

## Apache

To use Apache - we need to shut down nginx so we can have port 80 back and available. Run `/etc/init.d/nginx stop` to kill nginx.

### Installation

In our example here our VM will install Apache 2.2.3.

    # sudo yum install httpd

    # sudo cp -r /home/v6guru/ipv6-workshop-master/webfiles/*apache.conf /etc/httpd/conf.d/
    # sudo echo 'NameVirtualHost *:80' >> /etc/httpd/conf/httpd.conf
    # sudo ls /etc/httpd/conf.d

Just like we did with nginx we can copy our example configuration files. The important bits to note about Apache configuration are very similar to what you see in nginx - the Listen directive simply needs to be told to run on IPv6.

Unlike nginx, we need to edit the VirtualHost files to attach them to the correct IP address. Edit ipv4.apache.conf to use your VM's IPv4 address, ipv6.apache.conf to use your VM's IPv6 address.
  

## IIS

While we don't actually cover this in the workshop - the concepts are very similar for IIS. Change the Site Binding to include the IPv6 address as well as the IPv4 address as necessary. In this respect it treats an IPv4 address and an IPv6 address exactly alike.

## Tips and Tricks

Web Servers can also act as reverse proxies and SSL termination points for apps/servers that aren't (or shouldn't) be exposed directly. This allows you to cache, or act as an IPv6<->IPv4 bridge between a user and an application. [Netmap](http://netmap.cybera.ca) for example is a Tomcat based application we run that uses a web server to provide caching, IPv6 support and for security. (It's not a good idea to let a Java service run as root)

