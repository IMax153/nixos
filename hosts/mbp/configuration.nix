{
  config,
  lib,
  inputs,
  pkgs,
  self,
  ...
}: let
  inherit (lib) attrValues;

  primaryUser = config.modules.darwin.primary-user.username;

  users = attrValues (import ./users);
in {
  imports =
    users
    ++ [
      ./defaults
      ./homebrew
    ];

  # Environment Configuration
  environment = {
    pathsToLink = ["/share" "/bin" "/Applications"];
    systemPackages = with pkgs; [coreutils direnv findutils ncurses rsync];
  };

  # Home Manager Configuration
  home-manager.extraSpecialArgs = {inherit inputs self;};
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users = {
    "${primaryUser}" = import "${self}/hosts/mbp/home/${primaryUser}";
  };

  # Nix Configuration
  modules.common.nix = {
    enable = true;
  };

  # Primary User
  modules.darwin.primary-user = {
    username = "maxwellbrown";
    fullName = "Maxwell Brown";
    email = "maxwellbrown1990@gmail.com";
  };

  # Networking Configuration
  networking = {
    hostName = "mbp";
    # get via `networksetup -listallnetworkservices`
    knownNetworkServices = [
      "USB10/100/1000 LAN"
      "Wi-Fi"
      "Thunderbolt Bridge"
      "Tailscale Tunnel"
    ];
  };

  # Nixpkgs Configuration
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = attrValues self.overlays;
  };

  # Global Programs
  programs = {
    # Creates `/etc/zshrc` which loads the Nix Darwin environment
    zsh.enable = true;
  };

  # Enable TouchID for sudo
  security.pam.enableSudoTouchIdAuth = true;

  # Enforce the Nix Darwin state version - used for backwards compatibility,
  # please read the changelog before changing
  # $ darwin-rebuild changelog
  system.stateVersion = lib.mkDefault 4;
}
