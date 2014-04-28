# Mail

In this module we are going to install and configure a portion of a mail server stack (Postfix) on our VM. Like our other modules, adding IPv6 support is "easy" - the tools are available and do support IPv6 but they require testing and some planning. Unlike other modules, mail support has some interesting edge and use cases when it comes to interacting with other servers.

We'll only be setting up the Mail Transfer Agent portion so we can send/receive mail within our network and not any kind of storage so mail can be accessed.

## Considerations

Getting email to play nicely over IPv6 requires ensuring that each portion in the path that email takes needs to support IPv6 - both in your network and someone else's.

  * User to Your Mail Server
    Can you access your mail server via IPv6? There aren't any spam appliances, firewalls, etc. that block traffic?
  * Your Mail Server to Their Mail Server (or a relay)
    Can your mail server contact the other mail server over IPv6? If not it should use IPv4.
    If it can connect over IPv6 - are there any spam appliances, firewalls, etc. that would block/flag as spam IPv6 traffic?

For example some older Sonicwall or Barracuda devices don't support IPv6 at all and just drop the IPv6 traffic. This should be fine as the traffic should retry using IPv4. However some newer (but not recent) devices would accept IPv6 but by default flag it all as spam. It boils down to don't accept mail over IPv6 unless you know you can receive mail over IPv6.

Other best practice anti-spam technologies for sending mail (Reverse DNS, DKIM, Sender ID, and Sender Policy Framework) all support IPv6 but still need to be configured (eg. add a DNS PTR or TXT record). Some providers have taken morestrict approaches for requiring those technologies.

  > The sending IP must have a PTR record (i.e., a reverse DNS of the sending IP) and it should match the IP obtained via the forward DNS resolution of the hostname specified in the PTR record. Otherwise, mail will be marked as spam or possibly rejected.

When trying to send email via IPv6 from any host: [Google Support](https://support.google.com/mail/answer/81126?p=ipv6_authentication_error&rd=1#authentication)

## Installation

    # sudo yum install -y postfix

## Configuration

`inet_protocols` and `inet_interfaces` determine what should actually be used whether it's only specific interfaces, or protocols as well. For our example we want to edit `main.cf` in the `/etc/postfix`

We need to add the inet_protocols line, while inet_interfaces is already correctly defined.

    inet_protocols = all

OR

    inet_protocols = ipv4, ipv6

By default Postfix only works over IPv4 - so without that line it won't work. But that's all that needs to be done on Postifx to get it up and running on IPv6! 
