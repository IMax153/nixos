{
  perSystem = {pkgs, ...}: {
    packages = {
      segoe-ui-ttf = pkgs.callPackage ./segoe-ui-ttf.nix {};
    };
  };
}
