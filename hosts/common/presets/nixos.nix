{
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
    inputs.home-manager.nixosModules.home-manager

    ../global/nix/nixos.nix
    ../global/home-manager.nix
    ../global/locale.nix
    ../global/oom-killer.nix
    ../global/openssh.nix
    ../global/tailscale.nix

    ../users/maxwellbrown
  ];
  # ++ (builtins.attrValues (import ./../modules));

  boot = {
    cleanTmpDir = true;
  };

  sops = {
    age = {
      sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    };
  };

  environment = {
    pathsToLink = ["/share" "/bin"];
    systemPackages = [];
  };

  programs = {
    zsh = {
      enable = true;
    };
  };

  system = {
    stateVersion = lib.mkDefault "22.11";
  };
}
