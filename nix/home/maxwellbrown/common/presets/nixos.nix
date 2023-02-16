{pkgs, ...}: {
  imports = [
    ../global
  ];
  programs = {
    zsh = {
      shellAliases = {
        nixos-rebuild-switch = ''sudo nixos-rebuild --flake "git+file://$HOME/Code/github.com/maxwellbrown/nixos#$(hostname -s)" switch'';
        nixos-rebuild-boot = ''sudo nixos-rebuild --flake "git+file://$HOME/Code/github.com/maxwellbrown/nixos#$(hostname -s)" boot'';
      };
    };
  };
}
