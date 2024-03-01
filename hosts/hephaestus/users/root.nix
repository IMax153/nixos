{config, ...}: let
  adminKeys = config.users.users.maxwellbrown.openssh.authorizedKeys.keys;
in {
  boot.initrd.network.ssh.authorizedKeys = adminKeys;

  security.sudo.wheelNeedsPassword = false;

  users.users.root = {
    openssh.authorizedKeys.keys = adminKeys;
  };
}
