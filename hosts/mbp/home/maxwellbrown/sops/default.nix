{config, ...}: {
  home.sessionVariables = {
    SOPS_AGE_KEY_FILE = "${config.xdg.configHome}/sops/age/keys.txt";
  };
}
