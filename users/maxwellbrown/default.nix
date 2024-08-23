{config, ...}: {
  imports = [
    ../../home/aws.nix
    ../../home/direnv.nix
    ../../home/git.nix
    ../../home/k8s.nix
    ../../home/neovim
    ../../home/packages.nix
    ../../home/tmux.nix
    ../../home/ssh.nix
    ../../home/starship.nix
    ../../home/zsh

    ../../home/graphical/fonts.nix
    ../../home/graphical/kitty.nix
    ../../home/graphical/stylix.nix
    ../../home/graphical/vscode
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
