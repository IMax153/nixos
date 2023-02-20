{config, ...}: {
  imports = [
    ../common/presets/darwin.nix
  ];

  nixpkgs = {
    system = "aarch64-darwin";
  };

  networking = {
    hostName = "mbp2021";
  };
}
