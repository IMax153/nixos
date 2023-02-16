{config, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../common/presets/nixos.nix
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
