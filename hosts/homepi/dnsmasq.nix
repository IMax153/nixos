{...}: {
  services = {
    dnsmasq = {
      enable = true;
      servers = ["8.8.8.8" "1.1.1.1" "100.100.100.100"];
      extraConfig = ''
        # Tells dnsmasq to never forward A or AAAA queries for plain names,
        # without dots or domain parts, to upstream nameservers. If the name is
        # not known from /etc/hosts or DHCP then a "not found" answer is returned.
        domain-needed

        # All reverse lookups for private IP ranges (ie 192.168.x.x, etc) which
        # are not found in /etc/hosts or the DHCP leases file are answered with
        # "no such domain" rather than being forwarded upstream.
        bogus-priv

        # Don't read the hostnames in /etc/hosts.
        no-hosts

        # Don't read /etc/resolv.conf. Get upstream servers only from the command
        # line or the dnsmasq configuration file.
        no-resolv

        # Don't poll /etc/resolv.conf for changes.
        no-poll

        domain=thebrowns.home

        # Add domains which you want to force to an IP address here.
        # The example below send any host in double-click.net to a local
        # web-server.
        address=/www.thebrowns.home/127.0.0.1
      '';
    };
  };
}
