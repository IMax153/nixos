{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      awscli2
    ];

    sessionVariables = {
      AWS_CONFIG_FILE = "${config.xdg.configHome}/aws/config";
      AWS_SHARED_CREDENTIALS_FILE = "${config.xdg.configHome}/aws/credentials";
    };
  };
}
