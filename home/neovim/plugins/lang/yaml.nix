{
  programs.nixvim = {
    plugins.lsp.servers = {
      yamlls.enable = true;
    };
  };
}
