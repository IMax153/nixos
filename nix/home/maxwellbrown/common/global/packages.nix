{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    age
    curl
    gh
    jq
    moreutils
    unzip
    yq
  ];
}
