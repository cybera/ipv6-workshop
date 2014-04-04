# Setup

## Introduction

Each of these markdown files includes the notes, examples and walkthrough for using IPv6 with several services. For those familiar with setting up the services the steps for setting them up with IPv6 should appear familiar.

Code blocks will have a `#` or a `$` preceeding the lines. A `#` means the command should be run as root or by using sudo in front of it, whereas a `$` means a regular user can run this. While in our demo it's not imperative this be followed as we've made sure to include sudo in front of the commands that need to be run as root.

## Basic Commands

We're going to try and keep these demos as straight forward as possible so you'll need to make sure you're familiar with the following commands/programs:

  * `ifconfig` or `ip a` - to read an IP address
  * A text editor - eg. `vi`, `emacs`, or `nano`. Our examples will show `nano`.
  * `less` - for viewing files

## Getting Going

We're going to grab our scripts and documentation locally on our VM for running.

    $ wget --no-check-certificate https://github.com/cybera/ipv6-workshop/archive/master.zip
    $ unzip master

Be sure to record both your VM's IPv4 and IPv6 addresses (or use the `setIPs.sh` in the scripts folder)

    $ /sbin/ifconfig
    $ ~/ipv6-workshop-master/scripts/setIPs.sh

