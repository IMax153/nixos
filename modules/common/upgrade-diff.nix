{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.common.upgrade-diff;
in {
  options.modules.common.upgrade-diff = {
    enable = mkEnableOption "upgrade-diff";
  };

  config = mkIf cfg.enable {
    # Computes the diff between the current system and the new system on upgrades
    system.activationScripts.upgrade-diff = {
      supportsDryActivation = true;
      text = ''
        if [[ -e /run/current-system ]]; then
          echo "--- diff to current-system"
          ${pkgs.nvd}/bin/nvd --nix-bin-dir=${config.nix.package}/bin diff /run/current-system "$systemConfig"
          echo "---"
        fi
      '';
    };
  };
}
