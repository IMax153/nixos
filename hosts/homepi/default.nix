{config, ...}: {
  imports = [
    ../common/presets/nixos.nix
    ./dnsmasq.nix
    ./hardware-configuration.nix
    ./home-assistant.nix
  ];

  networking = {
    hostName = "homepi";

    firewall = {
      enable = true;
    };
  };

  nix = {
    settings = {
      min-free = 10374182400; # ~10GB
      max-free = 327374182400; # 32GB
      cores = 4;
      max-jobs = 8;
    };
  };
}
