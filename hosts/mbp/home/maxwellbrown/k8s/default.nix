{config, ...}: {
  home.sessionVariables = {
    KUBECONFIG = "${config.xdg.configHome}/kube/config";
  };
}
