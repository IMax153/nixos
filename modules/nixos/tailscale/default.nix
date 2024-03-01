{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption types;

  cfg = config.modules.nixos.tailscale;
in {
  options.modules.nixos.tailscale = {
    enable = mkEnableOption "tailscale";

    autoconnect = {
      enable = mkEnableOption "tailscale-autoconnect";
      authKeyFile = mkOption {
        type = types.path;
        description = "The path to a Tailscale authentication key used to connect to the tailnet";
      };
    };

    acceptDns = mkOption {
      type = types.bool;
      description = "Whether or not to allow Tailscale to accept upstream DNS requests";
      default = true;
    };
  };

  config = mkIf cfg.enable {
    networking.firewall = {
      enable = true;
      trustedInterfaces = ["tailscale0"];
      allowedUDPPorts = [config.services.tailscale.port];
    };

    services.tailscale.enable = true;

    systemd.services.tailscaled.serviceConfig.Environment = ["TS_ACCEPT_DNS=${lib.boolToString cfg.acceptDns}"];

    # Create a oneshot job to authenticate to Tailscale
    systemd.services.tailscale-autoconnect = mkIf cfg.autoconnect.enable {
      description = "Automatic connection to Tailscale";

      # Make sure tailscale is running before trying to connect to tailscale
      after = ["network-pre.target" "tailscale.service"];
      wants = ["network-pre.target" "tailscale.service"];
      wantedBy = ["multi-user.target"];

      # Set up this service as a oneshot job
      serviceConfig.Type = "oneshot";

      # Have the job run this shell script
      script = ''
        # Wait for tailscaled to settle
        sleep 2
        # Check if we are already authenticated to tailscale
        status="$(${pkgs.tailscale}/bin/tailscale status -json | ${pkgs.jq}/bin/jq -r .BackendState)"
        # If we are, do nothing
        if [ $status = "Running" ]; then
          exit 0
        fi
        # Otherwise authenticate with tailscale
        ${pkgs.tailscale}/bin/tailscale up -authkey file:${cfg.autoconnect.authKeyFile}
      '';
    };
  };
}
