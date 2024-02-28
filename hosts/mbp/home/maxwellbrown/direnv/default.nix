{
  config,
  pkgs,
  ...
}: {
  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
    stdlib = ''
      # enable asdf support
      use_asdf() {
        source_env "$(${pkgs.asdf-vm}/bin/asdf direnv envrc "$@")"
      }
    '';
    config = {
      global = {
        strict_env = true;
        warn_timeout = "12h";
      };
      whitelist = {
        prefix = ["${config.home.homeDirectory}/Code"];
      };
    };
  };
}
