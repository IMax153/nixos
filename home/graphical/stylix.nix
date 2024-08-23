{config, pkgs, ...}: {
  stylix = {
    enable = true;

    autoEnable = false;

    image = config.lib.stylix.pixel "base00";

    polarity = "dark";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
  };
}
