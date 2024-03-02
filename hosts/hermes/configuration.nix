{
  config,
  inputs,
  lib,
  modulesPath,
  self,
  ...
}: let
  inherit (lib) attrValues;

  users = attrValues (import ./users);
in {
  imports =
    users
    ++ [
      "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
      ./pihole
      ./network
    ];

  # Home Manager Configuration
  home-manager.extraSpecialArgs = {inherit inputs self;};
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users = {
    maxwellbrown = import "${self}/hosts/${config.networking.hostName}/home/maxwellbrown";
  };

  modules.common = {
    nix.enable = true;
    nix.sshServeUsers = ["maxwellbrown"];
    upgrade-diff.enable = true;
    well-known-hosts.enable = true;
  };

  modules.nixos = {
    tailscale = {
      enable = true;
      acceptDns = false;
      autoconnect.enable = true;
      autoconnect.authKeyFile = config.sops.secrets.tailscale-auth-key.path;
    };
  };

  networking = {
    hostName = "hermes";
    hostId = "8909daa4";
    firewall.allowedTCPPorts = [80];
  };

  nixpkgs = {
    hostPlatform = "aarch64-linux";

    overlays = [
      (_final: super: {
        makeModulesClosure = x:
          super.makeModulesClosure (x // {allowMissing = true;});
      })
    ];
  };

  programs = {
    # Creates `/etc/zshrc`
    zsh.enable = true;
  };

  sops.secrets.tailscale-auth-key = {
    format = "yaml";
    sopsFile = ./secrets.yaml;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
