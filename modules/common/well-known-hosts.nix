# A list of well known public keys
{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.common.well-known-hosts;
in {
  options.modules.common.well-known-hosts = {
    enable = mkEnableOption "well-known-hosts";
  };

  config = mkIf cfg.enable {
    # Avoid TOFU MITM with github by providing their public key here.
    programs.ssh.knownHosts = {
      "github.com".hostNames = ["github.com"];
      "github.com".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";

      "gitlab.com".hostNames = ["gitlab.com"];
      "gitlab.com".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAfuCHKVTjquxvt6CM6tdG4SLp1Btn/nOeHHE5UOzRdf";
    };
  };
}
