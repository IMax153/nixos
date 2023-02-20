{
  config,
  inputs,
  pkgs,
  ...
}: {
  home-manager = {
    users = {
      maxwellbrown = import "${inputs.self}/home/maxwellbrown/${config.networking.hostName}.nix";
    };
  };

  users = {
    users = {
      maxwellbrown = {
        name = "maxwellbrown";
        home = "/Users/${config.users.users.maxwellbrown.name}";
        shell = pkgs.zsh;
      };
    };
  };
}
