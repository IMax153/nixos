{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;

  ifTheyExist = users: builtins.filter (user: builtins.hasAttr user config.users.users) users;
  theirAuthorizedKeys = users: builtins.map (user: config.users.users.${user}.openssh.authorizedKeys.keys) users;

  isZfsRoot = lib.boolToString (!config.boot.isContainer or config.fileSystems."/".fsType != "zfs");

  cfg = config.modules.common.nix;
in {
  options.modules.common.nix = {
    enable = mkEnableOption "nix";

    sshServeUsers = mkOption {
      type = types.listOf types.str;
      description = "List of users who will have access to the Nix store as a remote store via SSH";
      default = [];
    };
  };

  config = mkIf cfg.enable {
    nix =
      {
        package = pkgs.nixVersions.nix_2_19;

        gc =
          {
            automatic = true;
            options = "--max-freed \"$((128 * 1024**3 - 1024 * $(df -P -k /nix/store | tail -n 1 | ${pkgs.gawk}/bin/awk '{ print $4 }')))\"";
          }
          // lib.optionalAttrs pkgs.stdenvNoCC.isLinux {
            dates = "*:45";
            # Randomize garbage collection to avoid thundering herd effects
            randomizedDelaySec = "1800";
          };

        nixPath = [
          "nixpkgs=${inputs.nixpkgs}"
          "home-manager=${inputs.home-manager}"
        ];

        registry = {
          nixpkgs.to = {
            type = "path";
            path = inputs.nixpkgs;
          };
          home-manager.to = {
            type = "path";
            path = inputs.home-manager;
          };
        };

        settings = {
          # Fallback quickly if substituters are not available
          connect-timeout = 5;

          # Avoid unnecessarily copying files over SSH
          builders-use-substitutes = true;

          # Enable flakes by default
          experimental-features = [
            "nix-command"
            "flakes"
            "repl-flake"
          ];

          # In ZFS we trust
          fsync-metadata = mkIf pkgs.stdenvNoCC.isLinux isZfsRoot;

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
          trusted-users = ["@wheel" "root"];

          upgrade-nix-store-path-url = "https://install.determinate.systems/nix-upgrade/stable/universal";

          fallback = true;
          warn-dirty = false;
          auto-optimise-store = true;
        };
      }
      // lib.optionalAttrs pkgs.stdenvNoCC.isLinux {
        # Nix Daemon Settings
        daemonCPUSchedPolicy = lib.mkDefault "batch";
        daemonIOSchedClass = lib.mkDefault "idle";
        daemonIOSchedPriority = lib.mkDefault 7;

        sshServe = {
          enable = true;
          keys = lib.flatten (theirAuthorizedKeys (ifTheyExist cfg.sshServeUsers));
          write = true;
        };
      }
      // lib.optionalAttrs pkgs.stdenvNoCC.isDarwin {
        configureBuildUsers = true;

        daemonProcessType = "Standard";
        daemonIOLowPriority = true;
      };

    # Auto upgrade nix package and the daemon service.
    services.nix-daemon = {
      enable = pkgs.stdenvNoCC.isDarwin;
    };
  };
}
