{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  darwinSockPath = "${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
  sockPath = "${config.home.homeDirectory}/.1password/agent.sock";
in {
  home = {
    file = {
      sock = lib.mkIf pkgs.stdenvNoCC.isDarwin {
        source = config.lib.file.mkOutOfStoreSymlink darwinSockPath;
        target = ".1password/agent.sock";
      };
    };

    sessionVariables = {
      SSH_AUTH_SOCK = sockPath;
    };
  };

  programs = {
    ssh = let
      darwinSockPath = "${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
      sockPath = "${config.home.homeDirectory}/.1password/agent.sock";
    in {
      enable = true;
      forwardAgent = true;
      extraConfig = ''
        IdentityAgent "${sockPath}"
        Host devbox
          Hostname 142.132.148.217
          User maxwellbrown
      '';
    };
  };
}
# TODO: look into completions / `1Password CLI` package
#   programs = {
#     bash = {
#       initExtra = lib.mkIf pkgs.stdenvNoCC.isDarwin ''
#         if command -v op >/dev/null; then
#           source <(op completion bash)
#         fi
#       '';
#     };
#     zsh = {
#       initExtra = lib.mkIf pkgs.stdenvNoCC.isDarwin ''
#         if command -v op >/dev/null; then
#           eval "$(op completion zsh)"; compdef _op op
#         fi
#       '';
#     };
#   };
# }
#   programs = {
#     bash = {
#       initExtra = lib.mkIf pkgs.stdenvNoCC.isDarwin ''
#         if command -v op >/dev/null; then
#           source <(op completion bash)
#         fi
#       '';
#     };
#     zsh = {
#       initExtra = lib.mkIf pkgs.stdenvNoCC.isDarwin ''
#         if command -v op >/dev/null; then
#           eval "$(op completion zsh)"; compdef _op op
#         fi
#       '';
#     };
#   };
# }

