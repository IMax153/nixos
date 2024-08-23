{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      kubectl
    ];

    sessionVariables = {
      KUBECONFIG = "${config.xdg.configHome}/kube/config";
    };
  };
}
