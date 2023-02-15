{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  shellInit = shell: "source " + cfg.package + "/Applications/iTerm2.app/Contents/Resources/iterm2_shell_integration." + shell;
  cfg = config.maxwellbrown.programs.iterm2;
in {
  options = {
    maxwellbrown = {
      programs = {
        iterm2 = {
          enable = mkEnableOption "Enables iTerm2 configuration management through home-manager";

          enableBashIntegration = mkOption rec {
            type = types.bool;
            default = config.programs.bash.enable;
            description = "Enable iTerm2 bash integration.";
            example = default;
          };

          enableFishIntegration = mkOption rec {
            type = types.bool;
            default = config.programs.fish.enable;
            description = "Enable iTerm2 fish integration.";
            example = default;
          };

          enableZshIntegration = mkOption rec {
            type = types.bool;
            default = config.programs.zsh.enable;
            description = "Enable iTerm2 zsh integration.";
            example = default;
          };

          package = mkOption {
            type = types.nullOr types.package;
            default =
              if stdenvNoCC.isDarwin
              then pkgs.iterm2
              else
                pkgs.iterm2.overrideAttrs (o: {
                  # Remove the generated binary
                  installPhase =
                    o.installPhase
                    + ''
                      rm -rf $out/bin
                    '';
                  meta.platforms = o.meta.platforms ++ lib.platforms.linux;
                });
            description = "The iTerm2 package to use.";
            example = "pkgs.iterm2";
          };

          plistPath = mkOption {
            type = types.nullOr types.path;
            default = null;
            description = "The com.googlecode.plist file to use for iTerm2 preferences.";
            example = "./com.googlecode.plist.iterm2";
          };

          profiles = mkOption {
            type = types.listOf types.path;
            default = [];
            description = "The profiles to load into iTerm2.";
            example = "[./my-user-profile.json]";
          };
        };
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      activation = mkIf (cfg.plistPath != null) {
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
          "${config.home.homeDirectory}/Library/Preferences/com.googlecode.iterm2.plist" = mkIf (cfg.plistPath != null) {
            source = cfg.plistPath;
          };
        }
        // builtins.listToAttrs (builtins.map (profile: let
            fileName = builtins.unsafeDiscardStringContext (builtins.baseNameOf profile);
          in {
            name = "${config.home.homeDirectory}/Library/Application Support/iTerm2/DynamicProfiles/${fileName}";
            value = {source = profile;};
          })
          cfg.profiles);

      packages = lib.optional (cfg.package != null) cfg.package;
    };

    programs = {
      bash = {
        initExtra = mkIf cfg.enableBashIntegration (shellInit "bash");
      };

      fish = {
        shellInit = mkIf cfg.enableFishIntegration (shellInit "fish");
      };

      zsh = {
        initExtra = mkIf cfg.enableZshIntegration (shellInit "zsh");
      };
    };
  };
}
