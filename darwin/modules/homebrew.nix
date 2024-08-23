{
  config,
  lib,
  ...
}: let
  brewEnabled = config.homebrew.enable;
in {
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.cleanup = "zap";
    global.brewfile = true;

    brews = [
      "podman"
      "podman-compose"
    ];
    casks = [
      "1password-cli"
      "keymapp"
      "obsidian"
      "podman-desktop"
      "yubico-yubikey-manager"
      "zoom"
    ];
    taps = [
      "homebrew/cask-fonts"
      "homebrew/cask-versions"
      "homebrew/services"
      "nrlquaker/createzap"
    ];
  };

  # Make sure homebrew path is setup properly
  environment.shellInit = lib.mkIf brewEnabled ''
    eval "$(${config.homebrew.brewPrefix}/brew shellenv)"
  '';

  programs = {
    # https://docs.brew.sh/Shell-Completion#configuring-completions-in-fish
    # For some reason if the Fish completions are added at the end of `fish_complete_path` they don't
    # seem to work, but they do work if added at the start.
    fish.interactiveShellInit = lib.mkIf brewEnabled ''
      if test -d (brew --prefix)"/share/fish/completions"
        set -p fish_complete_path (brew --prefix)/share/fish/completions
      end

      if test -d (brew --prefix)"/share/fish/vendor_completions.d"
        set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
      end
    '';

    # It seems as though only fish uses `environment.shellInit`
    zsh.shellInit = lib.mkIf brewEnabled ''
      eval "$(${config.homebrew.brewPrefix}/brew shellenv)"
    '';

    # https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
    zsh.interactiveShellInit = lib.mkIf brewEnabled ''
      if type brew &>/dev/null; then
        FPATH="$(brew --prefix)/share/zsh/site-functions:''${FPATH}"
        autoload -Uz compinit
        compinit
      fi
    '';
  };

  # Automatically install homebrew if it is not present on the system
  system.activationScripts.homebrew.text = lib.mkIf brewEnabled (
    lib.mkBefore ''
      if [[ ! -f "${config.homebrew.brewPrefix}/brew" ]]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      fi
    ''
  );
}
