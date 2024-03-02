{...}: {
  systemd.network.networks."10-uplink" = {
    matchConfig = {
      Name = "end0";
    };
    networkConfig = {
      DHCP = "ipv4";
    };
  };

  services.resolved = {
    extraConfig = ''
      DNSStubListener=no
    '';
  };
}
