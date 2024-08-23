{config, ...}: {
  programs.nixvim = {
    plugins.lspkind = {
      enable = true;
      cmp = {
        enable = true;
        maxWidth = 50;
        ellipsisChar = config.nixvim.icons.ui.Ellipsis;
        menu = {
          nvim_lsp = "[Lsp]";
          buffer = "[Buffer]";
          path = "[Path]";
          luasnip = "[LuaSnip]";
        };
      };
      symbolMap = config.nixvim.icons.kind;
    };
  };
}
