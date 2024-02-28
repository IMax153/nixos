{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) any elem mkIf;

  brewEnabled = config.homebrew.enable;
  caskPresent = cask: any (x: x.name == cask) config.homebrew.casks;
  homePackages = config.home-manager.users.${config.modules.darwin.primary-user.username}.home.packages;
in {
  environment.shellInit = mkIf brewEnabled ''
    eval "$(${config.homebrew.brewPrefix}/brew shellenv)"
  '';

  homebrew.enable = true;
  homebrew.onActivation.autoUpdate = true;
  homebrew.onActivation.cleanup = "zap";
  homebrew.global.brewfile = true;
  homebrew.brews = import ./brews.nix;
  homebrew.casks = import ./casks.nix;
  homebrew.taps = import ./taps.nix;

  # Configuration related to casks
  home-manager.users.${config.modules.darwin.primary-user.username} = mkIf (caskPresent "1password-cli" && config ? home-manager) {
    programs.ssh.enable = true;
    programs.ssh.extraConfig = ''
      # Only set `IdentityAgent` not connected remotely via SSH.
      # This allows using agent forwarding when connecting remotely.
      Match host * exec "test -z $SSH_TTY"
        IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    '';
    home.shellAliases = {
      cachix = mkIf (elem pkgs.cachix homePackages) "op plugin run -- cachix";
      gh = mkIf (elem pkgs.gh homePackages) "op plugin run -- gh";
    };
    home.sessionVariables = {
      # MY_SECRET = "op:// ...";
    };
  };

  # https://docs.brew.sh/Shell-Completion#configuring-completions-in-fish
  # For some reason if the Fish completions are added at the end of `fish_complete_path` they don't
  # seem to work, but they do work if added at the start.
  programs.fish.interactiveShellInit = mkIf brewEnabled ''
    if test -d (brew --prefix)"/share/fish/completions"
      set -p fish_complete_path (brew --prefix)/share/fish/completions
    end

    if test -d (brew --prefix)"/share/fish/vendor_completions.d"
      set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
    end
  '';

  # https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
  programs.zsh.interactiveShellInit = mkIf brewEnabled ''
    if type brew &>/dev/null; then
      FPATH="$(brew --prefix)/share/zsh/site-functions:''${FPATH}"
      autoload -Uz compinit
      compinit
    fi
  '';
}
