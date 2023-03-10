{
  config,
  pkgs,
  lib,
  inputs,
  username,
  ...
}: {
  imports = [
    inputs.home-manager.darwinModules.home-manager
    inputs.sops-nix.nixosModules.sops

    ../global/nix/darwin.nix
    ../global/home-manager.nix

    ../users/maxwellbrown/darwin.nix
  ];

  # packages installed in system profile
  environment = {
    systemPackages = with pkgs; [
      # darwin-zsh-completions
      # lima
      # only to provide tmux-256color terminfo
      # until macos ships with newer ncurses
      ncurses
    ];

    pathsToLink = ["/share" "/bin" "/Applications"];
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    taps = [
      "homebrew/cask"
    ];
    casks = [
      "zoom"
    ];

    masApps = {
      Tailscale = 1475387142;
    };
  };

  networking = {
    # get via `networksetup -listallnetworkservices`
    knownNetworkServices = [
      "Wi-Fi"
    ];
    dns = ["1.1.1.1" "1.0.0.1"];
  };

  programs = {
    # needed to Create /etc/zshrc that loads the nix-darwin environment.
    zsh = {
      enable = true;
    };
  };

  system = {
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = lib.mkDefault 4;

    defaults = {
      dock = {
        show-recents = false;
      };
      finder = {
        ShowStatusBar = true;
        ShowPathbar = true;
      };
      trackpad = {
        Clicking = true;
      };
      loginwindow = {
        GuestEnabled = false;
        DisableConsoleAccess = true;
      };
      NSGlobalDomain = {
        _HIHideMenuBar = false;
        AppleInterfaceStyle = "Dark";
        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.feedback" = 1;
        "com.apple.swipescrolldirection" = true;
        "com.apple.trackpad.enableSecondaryClick" = true;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
      };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };
}
