# Mail

In this module we are going to install and configure a mail server (Postfix) on our VM. Like our other modules, adding IPv6 support is "easy" - the tools are available and do support IPv6 but they require testing and some planning. Unlike other modules, mail support has some interesting edge and use cases when it comes to interacting with other servers.

## Installation

    #sudo yum install -y postfix


## Configuration

`inet_protocols` and `inet_interfaces` determine what it's actually using.

## The importance of reverse DNS

Many email hosts, especially the larger ones heavily leverage reverse DNS when it comes to IPv6.

eg. Gmail:

  > The sending IP must have a PTR record (i.e., a reverse DNS of the sending IP) and it should match the IP obtained via the forward DNS resolution of the hostname specified in the PTR record. Otherwise, mail will be marked as spam or possibly rejected.

[Google Support](https://support.google.com/mail/answer/81126?p=ipv6_authentication_error&rd=1#authentication)

## Exercises

Try sending mail via IPv4 and IPv6.


