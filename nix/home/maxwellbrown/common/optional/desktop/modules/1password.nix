{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  sshAuthSock = "${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
in {
  home = {
    file = {
      sock = {
        source = config.lib.file.mkOutOfStoreSymlink darwinSockPath;
        target = "${config.home.homeDirectory}/.1password/agent.sock";
      };
    };

    programs = {
      bash = {
        initExtra = lib.mkIf pkgs.stdenvNoCC.isDarwin ''
          if command -v op >/dev/null; then
            source <(op completion bash)
          fi
        '';
      };
      zsh = {
        initExtra = lib.mkIf pkgs.stdenvNoCC.isDarwin ''
          if command -v op >/dev/null; then
            eval "$(op completion zsh)"; compdef _op op
          fi
        '';
      };
    };

    sessionVariables = {
      SSH_AUTH_SOCK = sshAuthSock;
    };
  };
}
