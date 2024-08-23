{
  lib,
  pkgs,
  ...
}: let
  users = ["maxwellbrown"];
in {
  home-manager.users = lib.genAttrs users (user: {
    imports = [
      {
        home.username = user;
        home.homeDirectory = "/Users/${user}";
      }
      ../../users/${user}
    ];
  });

  users.users = lib.genAttrs users (user: {
    name = user;
    home = "/Users/${user}";
    shell = pkgs.zsh;
  });
}
