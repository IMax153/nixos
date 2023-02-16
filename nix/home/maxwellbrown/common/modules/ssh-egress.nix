{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.maxwellbrown.programs.ssh-egress;
in {
  options = {
    maxwellbrown = {
      programs = {
        ssh-egress = {
          enable = mkEnableOption "Enables ssh-egress configuration through home-manager";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    # programs.git.signing = {
    #   key = "${config.home.homeDirectory}/.ssh/personal";
    #   signByDefault = true;
    # };

    programs = {
      ssh = let
        agentPath = "${config.home.homeDirectory}/.1password/agent.sock";
      in {
        enable = true;
        compression = true;
        controlMaster = "auto";
        controlPath = "/tmp/%r@%h:%p";
        controlPersist = "1m";
        serverAliveCountMax = 6;
        serverAliveInterval = 15;
        matchBlocks = {
          git = {
            host = "github.com gitlab.com bitbucket.org";
            user = "git";
            # identityFile = "${config.home.homeDirectory}/.ssh/personal";
          };
          tailscale = {
            host = "devbox github-runner homepi mbp2021";
            user = "${config.home.username}";
            forwardAgent = true;
            extraOptions = {
              IdentityAgent = agentPath;
            };
            # identityFile = "${config.home.homeDirectory}/.ssh/personal";
          };
          devbox = hm.dag.entryAfter ["tailscale"] {
            hostname = "142.132.148.217";
          };
          github-runner = hm.dag.entryAfter ["tailscale"] {
            hostname = "141.125.106.37";
          };
          homepi = hm.dag.entryAfter ["tailscale"] {
            hostname = "100.106.191.128";
          };
          mbp2021 = hm.dag.entryAfter ["tailscale"] {
            hostname = "73.10.224.122";
            user = "ubuntu";
          };
        };
      };
    };
  };
}
