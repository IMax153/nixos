{
  # Inserts matching pairs of parens, brackets, etc.
  # https://nix-community.github.io/nixvim/plugins/nvim-autopairs/index.html
  programs.nixvim = {
    plugins.nvim-autopairs = {
      enable = true;
    };

    extraConfigLua =
      # lua
      ''
        require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
      '';
  };
}
