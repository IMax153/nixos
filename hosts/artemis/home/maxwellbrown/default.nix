{
  config,
  lib,
  ...
}: {
  imports = [
    ./zsh
  ];

  # Home Manager Configuration
  home = {
    username = lib.mkDefault "maxwellbrown";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
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
