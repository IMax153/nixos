{...}: let
  maxwellbrown = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPsBd6asppvftBGAxsu2MutHRiFKQIsyMakAheN/2GzK"];
  extraGroups = ["docker" "wheel"];
in {
  users.users = {
    maxwellbrown = {
      inherit extraGroups;
      isNormalUser = true;
      home = "/home/maxwellbrown";
      shell = "/run/current-system/sw/bin/zsh";
      uid = 1000;
      openssh.authorizedKeys.keys = maxwellbrown;
    };
  };
}
