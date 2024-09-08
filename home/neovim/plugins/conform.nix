{pkgs, ...}: {
  programs.nixvim = {
    extraPackages = with pkgs; [
      alejandra
      jq
      stylua
    ];

    # Autoformat
    # https://nix-community.github.io/nixvim/plugins/conform-nvim.html
    plugins.conform-nvim = {
      enable = true;
      settings = {
        notify_on_error = false;
        formatters_by_ft = {
          json = ["jq"];
          lua = ["stylua"];
          nix = ["alejandra"];
        };
        format_on_save =
          # lua
          ''
            function(bufnr)
              -- Disable autoformat for file types handled by ESLint
              local ignore_filetypes = { "js", "jsx", "ts", "tsx" }
              if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
                return
              end
              -- Disable with a global or buffer-local variable
              if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
              end
              -- Disable autoformat for files in a certain path
              local bufname = vim.api.nvim_buf_get_name(bufnr)
              if bufname:match("/node_modules/") then
                return
              end
              return { timeout_ms = 500, lsp_format = "never" }
            end
          '';
      };
    };
  };
}
