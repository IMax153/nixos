{...}: {
  systemd.network.networks."10-uplink" = {
    matchConfig = {
      # There are four physical network interfaces on artemis (eno1-eno4), but
      # for now we only configure the uplink interface
      Name = "eno1";
    };
    networkConfig = {
      DHCP = "ipv4";
    };
  };
}
