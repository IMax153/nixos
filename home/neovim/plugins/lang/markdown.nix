{
  programs.nixvim = {
    plugins.lsp.servers.marksman = {
      enable = true;
    };
  };
}