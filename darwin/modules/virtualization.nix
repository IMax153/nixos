{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      podman
      qemu
      xz
    ];

    # https://github.com/containers/podman/issues/17026
    pathsToLink = [ "/share/qemu" ];

    # https://github.com/LnL7/nix-darwin/issues/432#issuecomment-1024951660
    etc."containers/containers.conf.d/99-gvproxy-path.conf".text = ''
      [engine]
      helper_binaries_dir = ["${pkgs.gvproxy}/bin"]
    '';
  };
}
