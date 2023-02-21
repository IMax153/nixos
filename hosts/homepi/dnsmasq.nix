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

        # Specifies DNS domains for the DHCP server.
        domain=home.local
        local=/home.local

        # Specify how to resolve specific subdomains
        address=/.home.local/127.0.0.1
      '';
    };
  };
}
