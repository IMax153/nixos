{config, ...}: {
  home.sessionVariables = {
    AWS_CONFIG_FILE = "${config.xdg.configHome}/aws/config";
    AWS_SHARED_CREDENTIALS_FILE = "${config.xdg.configHome}/aws/credentials";
  };
}
