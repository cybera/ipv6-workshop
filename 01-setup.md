# Setup

## Introduction

Each of these markdown files includes the notes, examples and walkthrough for using IPv6 with several services. For those familiar with setting up the services the steps for setting them up with IPv6 should appear familiar.

Code blocks will have a `#` or a `$` preceeding the lines. A `#` means the command should be run as root or by using sudo in front of it, whereas a `$` means a regular user can run this. While in our demo it's not imperative this be followed as we've made sure to include sudo in front of the commands that need to be run as root.

## Getting Going

With our CentOS 5.5 VM we need to run a couple commands just to make sure we have all the necessary pieces. To make life easier we're using EPEL on top of CentOS to make installation of some newer pacakages more manageable.

    # wget http://mirror.its.dal.ca/pub/epel/5/i386/epel-release-5-4.noarch.rpm
    # sudo rpm -Uvh ./epel-release-5.4.noarch.rpm

    # sudo yum update
    # sudo yum upgrade

Next we're going to install a couple helper tools.

    # sudo yum install git
    $ git clone https://github.com/cybera/ipv6-system /home/root/ipv6/

Be sure to record your VM's IP addresses:

    $ /usr/sbin/ifconfig

