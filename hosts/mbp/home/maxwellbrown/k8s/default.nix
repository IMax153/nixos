{config, ...}: {
  home.sessionVariables = {
    KUBECONFIG = "${config.home.homeDirectory}/.kube/config";
  };
}
