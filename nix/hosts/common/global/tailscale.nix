{config, ...}: {
  # Enable tailscale. We manually authenticate when we want with
  # "sudo tailscale up". If you don't use tailscale, you should comment
  # out or delete all of this.
  services = {
    tailscale = {
      enable = true;
    };
  };
  networking = {
    firewall = {
      allowedTCPPorts = [22];
      allowedUDPPorts = [
        config.services.tailscale.port
      ];
      checkReversePath = "loose";
      trustedInterfaces = ["tailscale0"];
    };
  };
}
