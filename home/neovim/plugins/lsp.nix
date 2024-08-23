{config, ...}: let
  inherit (import ../keymap-utils.nix) inoremap nnoremap;
in {
  programs.nixvim = {
    plugins = {
      fidget = {
        enable = true;
      };

      lsp = {
        enable = true;

        capabilities =
          # lua
          ''
            local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()
            capabilities = vim.tbl_deep_extend("force", capabilities, cmp_capabilities)
          '';

        keymaps = {
          # Mappings for `vim.diagnostic.<action>` functions to be added when an
          # LSP it attached
          diagnostic = {
            "]d" = {
              action = "goto_next";
              desc = "Goto Next Diagnostic";
            };
            "[d" = {
              action = "goto_prev";
              desc = "Goto Previous Diagnostic";
            };
          };

          # Mappings for `vim.lsp.buf.<action>` functions to be added when an
          # LSP it attached
          lspBuf = {
            "K" = {
              action = "hover";
              desc = "Hover Documentation";
            };
            "<leader>ca" = {
              action = "code_action";
              desc = "LSP: [C]ode [A]ction";
            };
            "<leader>rn" = {
              action = "rename";
              desc = "LSP: [R]ename";
            };
            "<leader>k" = {
              action = "signature_help";
              desc = "LSP: [S]ignature [H]elp";
            };
            "gd" = {
              action = "definition";
              desc = "LSP: [G]oto [D]efinition";
            };
            "gD" = {
              action = "declaration";
              desc = "LSP: [G]oto [D]eclaration";
            };
            "gt" = {
              action = "type_definition";
              desc = "LSP: [G]oto [T]ype Definition";
            };
          };

          extra = [
            (inoremap "<C-k>" "<cmd>lua vim.lsp.buf.signature_help()<cr>" "LSP: [S]ignature [H]elp")
            (nnoremap "<leader>d" {
              __raw =
                # lua
                ''
                  function()
                    vim.diagnostic.open_float(nil, { focus = false })
                  end
                '';
            } "LSP: Show Line [D]iagnostics")
            (nnoremap "<leader>ll" {
              __raw =
                # lua
                ''
                  function()
                    if vim.diagnostic.config().virtual_text == false then
                      vim.diagnostic.config({
                        virtual_text = {
                          source = "always",
                          prefix = "●",
                        },
                      })
                    else
                      vim.diagnostic.config({
                        virtual_text = false,
                      })
                    end
                  end
                '';
            } "LSP: Toggle Inline Diagnostics")
            (nnoremap "<leader>lL" {
              __raw =
                # lua
                ''
                  function()
                    if vim.g.diagnostics_visible then
                      vim.g.diagnostics_visible = false
                      vim.diagnostic.disable()
                    else
                      vim.g.diagnostics_visible = true
                      vim.diagnostic.enable()
                    end
                  end
                '';
            } "LSP: Toggle Diagnostics")
          ];
        };
      };
    };

    extraConfigLua =
      # lua
      ''
        local signs = {
          Hint = "${config.nixvim.icons.diagnostics.BoldHint}",
          Info = "${config.nixvim.icons.diagnostics.BoldInformation}",
          Warn = "${config.nixvim.icons.diagnostics.BoldWarning}",
          Error = "${config.nixvim.icons.diagnostics.BoldError}",
        }

        for type, icon in pairs(signs) do
          local hl = "DiagnosticSign" .. type
          vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        local _border = "rounded"

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
          vim.lsp.handlers.hover, {
            border = _border,
          }
        )

        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
          vim.lsp.handlers.signature_help, {
            border = _border,
          }
        )
      '';
  };
}
