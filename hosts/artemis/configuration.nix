{
  config,
  inputs,
  lib,
  self,
  ...
}: let
  inherit (lib) attrValues;

  users = attrValues (import ./users);
in {
  imports =
    users
    ++ [
      ./hardware-configuration.nix
      ./disko
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
    tailscale.enable = true;
    tailscale.autoconnect.enable = true;
    tailscale.autoconnect.authKeyFile = config.sops.secrets.tailscale-auth-key.path;
  };

  networking = {
    hostName = "artemis";
    hostId = "805c2520";
  };

  nixpkgs.hostPlatform = "x86_64-linux";

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
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
