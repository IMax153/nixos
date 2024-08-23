{config, ...}: let
  dotDir = builtins.replaceStrings ["${config.home.homeDirectory}/"] [""] "${config.xdg.configHome}/zsh";
in {
  programs.zsh = {
    inherit dotDir;
    enable = true;
    enableCompletion = true;
    autocd = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "viins";
    completionInit = builtins.readFile ./completions.zsh;
    history = import ./history.nix {inherit config;};
    initExtra = builtins.readFile ./init.zsh;
    profileExtra = builtins.readFile ./profile.zsh;
  };
}
