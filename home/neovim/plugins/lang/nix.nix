{...}: {
  programs.nixvim = {
    plugins = {
      nix.enable = true;
      nix-develop.enable = true;
      lsp.servers = {
        nixd.enable = true;
        nil-ls.enable = true;
      };
    };
  };
}
