{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./common/presets/darwin.nix
  ];

  home = {
    homeDirectory = "/Users/${config.home.username}";
  };

  fontProfiles = {
    enable = true;
    monospace.size = 16.0;
  };

  maxwellbrown = {
    programs = {
      alacritty = {
        enable = true;
        package = pkgs.alacritty;
      };

      iterm2 = {
        enable = true;
        package = pkgs.iterm2;
        plistPath = "${inputs.self}/files/iterm2/com.googlecode.iterm2.plist";
        profiles = [
          "${inputs.self}/files/iterm2/maxwellbrown.json"
        ];
      };

      ssh-egress = {
        enable = true;
      };
    };
  };
}
