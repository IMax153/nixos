{
  pkgs,
  self,
  ...
}: let
  inherit (self.packages.${pkgs.stdenv.hostPlatform.system}) segoe-ui-ttf;
in {
  fonts.fontconfig.defaultFonts = {
    # Always prefer emojis even if the original font would provide a glyph
    monospace = ["emoji"];
    sansSerif = ["emoji"];
    serif = ["emoji"];
  };

  home.packages = with pkgs; [
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    noto-fonts-extra
  ];

  stylix.fonts = {
    serif = {
      package = pkgs.dejavu_fonts;
      name = "IBM Plex Serif";
    };

    sansSerif = {
      package = segoe-ui-ttf;
      name = "Segoe UI";
    };

    monospace = {
      # No need for patched nerd fonts, kitty can pick up on them automatically,
      # and ideally every program should do that: https://sw.kovidgoyal.net/kitty/faq/#kitty-is-not-able-to-use-my-favorite-font
      package = pkgs.jetbrains-mono;
      name = "JetBrains Mono";
    };

    emoji = {
      package = segoe-ui-ttf;
      name = "Segoe UI Emoji";
    };
  };
}
