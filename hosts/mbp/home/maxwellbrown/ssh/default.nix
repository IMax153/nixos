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
      tailscale = {
        host = "devbox github-runner homepi mbp2021";
        user = config.home.username;
        forwardAgent = true;
      };
    };
    # # TODO: move to homebrew section
    # extraConfig = ''
    #   # Only set `IdentityAgent` if not connected remotely via SSH.
    #   # This allows using agent forwarding when connecting remotely.
    #   Match host * exec "test -z $SSH_TTY"
    #     IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    # '';
  };
}
