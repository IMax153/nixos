{ config, ... }:
{
  imports = [
    ../../home/direnv.nix
    ../../home/git.nix
    ../../home/k8s.nix
    ../../home/packages.nix
    ../../home/tmux.nix
    ../../home/ssh.nix
    ../../home/starship.nix
    ../../home/terraform.nix
    ../../home/zsh

    ../../home/graphical/fonts.nix
    ../../home/graphical/ghostty.nix
    ../../home/graphical/stylix.nix
    ../../home/graphical/vscode

    ./nixvim.nix
  ];

  targets.darwin = {
    currentHostDefaults = {
      "com.apple.controlcenter" = {
        BatteryShowPercentage = true;
      };
    };

    search = "Google";
  };

  xdg = {
    enable = true;
    configHome = "${config.home.homeDirectory}/.config";
    cacheHome = "${config.home.homeDirectory}/.cache";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";
  };
}
