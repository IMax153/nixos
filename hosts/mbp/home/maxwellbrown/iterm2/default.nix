{
  config,
  lib,
  pkgs,
  ...
}: let
  shellInit = shell: "source " + pkgs.iterm2 + "/Applications/iTerm2.app/Contents/Resources/iterm2_shell_integration." + shell;
  profiles = [./maxwellbrown.json];
in {
  home = {
    activation = {
      readIterm2Settings = lib.hm.dag.entryAfter ["writeBoundary"] ''
        if [[ -n $VERBOSE_ARG ]]; then
          $DRY_RUN_CMD /usr/bin/defaults read com.googlecode.iterm2
        else
          $DRY_RUN_CMD /usr/bin/defaults read com.googlecode.iterm2 > /dev/null
        fi
      '';
    };

    file =
      {
        "${config.home.homeDirectory}/Library/Preferences/com.googlecode.iterm2.plist" = {
          source = ./com.googlecode.iterm2.plist;
        };
      }
      // builtins.listToAttrs (builtins.map (profile: let
          fileName = builtins.unsafeDiscardStringContext (builtins.baseNameOf profile);
        in {
          name = "${config.home.homeDirectory}/Library/Application Support/iTerm2/DynamicProfiles/${fileName}";
          value = {source = profile;};
        })
        profiles);
  };

  programs = {
    bash.initExtra = shellInit "bash";
    fish.shellInit = shellInit "fish";
    zsh.initExtra = shellInit "zsh";
  };
}
