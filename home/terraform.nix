{config, ...}: let
  pluginCacheDir = "${config.xdg.cacheHome}/terraform/plugin-cache";
  terraformConfigFile = "${config.xdg.configHome}/terraform.tfrc";
in {
  home = {
    file = {
      "${pluginCacheDir}/.keep" = {
        recursive = true;
        text = "";
      };
    };

    sessionVariables = {
      TF_CLI_CONFIG_FILE = terraformConfigFile;
    };
  };

  xdg.configFile."terraform.tfrc" = {
    text = ''
      plugin_cache_dir = "${pluginCacheDir}"
    '';
  };
}
