{
  config,
  pkgs,
  ...
}: let
  primaryUser = config.modules.darwin.primary-user.username;
in {
  users.users.${primaryUser} = {
    name = primaryUser;
    home = "/Users/${config.users.users.${primaryUser}.name}";
    shell = pkgs.zsh;
  };
}
