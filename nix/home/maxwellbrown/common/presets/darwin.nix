{pkgs, ...}: {
  imports = [
    ../global
    # selectively import desktop modules
    ../optional/desktop/common/font.nix
  ];

  home = {
    packages = with pkgs; [
      coreutils
      findutils
    ];

    sessionVariables = {
      XDG_RUNTIME_DIR = "$TMPDIR";
    };
  };

  programs = {
    zsh = {
      shellAliases = {
        touchbar-restart = "sudo pkill TouchBarServer";
        tailscale = "/Applications/Tailscale.app/Contents/MacOS/Tailscale";
        # TODO: fix pathing here
        darwin-rebuild-switch = ''darwin-rebuild switch --flake "git+file://$HOME/Code/github.com/konradmalik/dotfiles#$(hostname -s)"'';
      };
    };
  };

  targets = {
    darwin = {
      currentHostDefaults = {
        "com.apple.controlcenter" = {
          BatteryShowPercentage = true;
        };
      };

      defaults = {
        NSGlobalDomain = {
          AppleMeasurementUnits = "Inches";
          AppleMetricUnits = false;
          AppleTemperatureUnit = "Fahrenheit";
          NSAutomaticCapitalizationEnabled = false;
          NSAutomaticDashSubstitutionEnabled = false;
          NSAutomaticPeriodSubstitutionEnabled = false;
          NSAutomaticQuoteSubstitutionEnabled = false;
          NSAutomaticSpellingCorrectionEnabled = false;
        };
        "com.apple.desktopservices" = {
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.dock" = {
          expose-group-apps = true;
          size-immutable = true;
          tilesize = 48;
        };
      };

      search = "Google";
    };
  };
}
