{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./aws
    ./colorscheme
    ./direnv
    ./fonts
    ./git
    ./iterm2
    ./k8s
    ./ssh
    ./starship
    ./terraform
    ./vscode
    ./zsh
  ];

  # System Preferences Configuration
  targets.darwin = {
    currentHostDefaults = {
      "com.apple.controlcenter" = {
        BatteryShowPercentage = true;
      };
    };

    search = "Google";
  };

  # Home Manager Configuration
  home = {
    username = lib.mkDefault config.modules.darwin.primary-user.username;
    homeDirectory = lib.mkDefault "/Users/${config.home.username}";
    stateVersion = "24.05";
  };

  # XDG Base Directory Specification
  xdg = {
    enable = true;
    configHome = "${config.home.homeDirectory}/.config";
    cacheHome = "${config.home.homeDirectory}/.cache";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";
  };
}
