{pkgs, ...}: {
  home.packages = with pkgs; [qovery-cli];
}
