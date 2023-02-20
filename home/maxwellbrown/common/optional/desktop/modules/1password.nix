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
        source = config.lib.file.mkOutOfStoreSymlink sshAuthSock;
        target = "${config.home.homeDirectory}/.1password/agent.sock";
      };
    };

    sessionVariables = {
      SSH_AUTH_SOCK = sshAuthSock;
    };
  };
}
