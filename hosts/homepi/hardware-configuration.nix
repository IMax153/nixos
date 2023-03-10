{
  inputs,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.raspberry-pi-4

    "${modulesPath}/installer/sd-card/sd-image-aarch64.nix"
  ];

  nixpkgs = {
    hostPlatform = lib.mkDefault "aarch64-linux";
  };
}
