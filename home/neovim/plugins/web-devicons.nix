{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      nvim-web-devicons
    ];

    extraConfigLuaPre =
      # lua
      ''
        if vim.g.have_nerd_font then
          require("nvim-web-devicons").setup({})
        end
      '';
  };
}
