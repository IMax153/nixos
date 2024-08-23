{
  lib,
  inputs,
  self,
  ...
}: {
  imports = [
    # Flake Modules
    inputs.home-manager.darwinModules.home-manager

    # Top-Level Modules
    "${self}/modules/home-manager.nix"

    # System-Specific Modules
    ../../modules/defaults.nix
    ../../modules/homebrew.nix
    ../../modules/nix-daemon.nix
    ../../modules/sudo.nix
    ../../modules/users.nix
  ];

  networking.hostName = "heimdall";

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "vscode"
        "vscode-extension-MS-python-vscode-pylance"
        "vscode-extension-ms-vscode-remote-remote-ssh"
      ];
  };

  # Enforce the Nix Darwin state version - used for backwards compatibility,
  # please read the changelog before changing
  # $ darwin-rebuild changelog
  system.stateVersion = lib.mkDefault 4;
}
