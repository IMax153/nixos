{ pkgs, ... }:
{
  stylix.targets.tmux.enable = true;

  programs.tmux = {
    enable = true;
    sensibleOnTop = false;
    escapeTime = 300;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";
    # shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    extraConfig = builtins.readFile ./tmux.conf;
    plugins = [
      pkgs.tmuxPlugins.vim-tmux-navigator

      {
        plugin = pkgs.tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }

      {
        plugin = pkgs.tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-boot 'on'
          set -g @continuum-save-interval '10'
        '';
      }
    ];
  };
}
