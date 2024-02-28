{...}: {
  system.defaults = {
    NSGlobalDomain = {
      _HIHideMenuBar = false;
      AppleInterfaceStyle = "Dark";
      AppleInterfaceStyleSwitchesAutomatically = true;
      AppleMeasurementUnits = "Inches";
      AppleMetricUnits = 0;
      AppleShowScrollBars = "Automatic";
      AppleTemperatureUnit = "Fahrenheit";
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      "com.apple.trackpad.enableSecondaryClick" = true;
    };

    CustomUserPreferences = {
      "com.microsoft.VSCode" = {
        ApplePressAndHoldEnabled = false;
      };
      "com.microsoft.VSCodeInsiders" = {
        ApplePressAndHoldEnabled = false;
      };
      "com.microsoft.VSCodeExploration" = {
        ApplePressAndHoldEnabled = false;
      };
      "com.visualstudio.code.oss" = {
        ApplePressAndHoldEnabled = false;
      };
    };

    dock = {
      autohide = true;
      expose-group-by-app = false;
      mru-spaces = false;
      show-recents = false;
      tilesize = 48;
      # Disable all hot corners
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
    };

    finder = {
      ShowStatusBar = true;
      ShowPathbar = true;
    };

    loginwindow = {
      GuestEnabled = false;
      DisableConsoleAccess = true;
    };

    trackpad = {
      Clicking = true;
    };
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };
}
