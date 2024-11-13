{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.nix-daemon.enable = true;

  nix = {
    package = pkgs.nixVersions.latest;

    # Make the Nix daemon low priority when doing system IO
    daemonIOLowPriority = lib.mkDefault true;

    gc = {
      # Automatically trigger the Nix garbage collector at a specified interval
      automatic = true;

      # The interval on which the Nix garbage collector will be triggered
      interval = {
        Hour = 3;
        Minute = 15;
      };

      # Options given to `nix-collect-garbage`
      options = "--delete-older-than 10d";
    };

    settings = {
      # Avoid unnecessarily copying files over SSH
      builders-use-substitutes = true;

      # Fallback quickly if substituters are not available
      connect-timeout = 5;

      # Enable flakes by default
      experimental-features =
        [
          "nix-command"
          "flakes"
        ]
        ++ lib.optional (lib.versionOlder (lib.versions.majorMinor config.nix.package.version) "2.22") "repl-flake";

      # Fallback to building from source if a binary substitution fails
      fallback = true;

      # For nix-direnv
      keep-outputs = true;
      keep-derivations = true;

      # The default of 10 is rarely enough
      log-lines = lib.mkDefault 25;

      # Ensure Nix does not fill up the disk
      max-free = lib.mkDefault (3000 * 1024 * 1024);
      min-free = lib.mkDefault (512 * 1024 * 1024);

      # Substituter Configurations
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      # Nix Store Access Control
      trusted-users = [
        "@admin"
        "maxwellbrown"
        "root"
      ];

      # Warn about dirty VCS trees
      warn-dirty = false;
    };
  };
}
