{config, ...}: let
  maxwellbrownKeys = config.users.users.maxwellbrown.openssh.authorizedKeys.keys;
in {
  roles.nix-remote-builder = {
    schedulerPublicKeys = maxwellbrownKeys;
  };
}
