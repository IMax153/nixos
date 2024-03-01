{...}: {
  systemd.network.networks."10-uplink" = {
    matchConfig = {
      Name = "enp0s6";
    };
    networkConfig = {
      DHCP = "ipv4";
    };
  };
}
