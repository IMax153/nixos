{config, ...}: {
  programs.ssh = {
    enable = true;
    compression = true;
    controlMaster = "auto";
    controlPath = "${config.home.homeDirectory}/.ssh/sockets/%r@%h:%p";
    controlPersist = "1m";
    serverAliveCountMax = 6;
    serverAliveInterval = 15;
    matchBlocks = {
      git = {
        host = "github.com gitlab.com bitbucket.org";
        user = "git";
      };
    };
    extraConfig = ''
      # Only set `IdentityAgent` not connected remotely via SSH.
      # This allows using agent forwarding when connecting remotely.
      Match host * exec "test -z $SSH_TTY"
        IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    '';
  };
}
