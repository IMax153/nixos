{
  config,
  lib,
  ...
}: let
  dotDir = builtins.replaceStrings ["${config.home.homeDirectory}/"] [""] "${config.xdg.configHome}/zsh";
in {
  programs.zsh = {
    inherit dotDir;
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    defaultKeymap = "viins";
    profileExtra = lib.readFile ./profile.zsh;
    history = import ./history.nix {inherit config;};
    initExtra = lib.readFile ./init.zsh;
    completionInit = lib.readFile ./completions.zsh;
  };
}
