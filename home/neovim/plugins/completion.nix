{
  programs.nixvim = {
    plugins = {
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp_luasnip.enable = true;
      cmp-nvim-lsp-signature-help.enable = true;

      luasnip = {
        enable = true;
        fromVscode = [{} {paths = ./snippets;}];
        settings = {
          # Update dynamic snippets while typing
          updateevents = "TextChanged,TextChangedI";
        };
      };

      cmp = {
        enable = true;
        settings = {
          complete = {
            completeopt = "menu,menuone,noinsert";
          };

          experimental = {
            ghost_text = true;
          };

          formatting = {
            expandable_indicator = true;
          };

          snippet = {
            expand =
              # lua
              ''
                function(args)
                  require("luasnip").lsp_expand(args.body)
                end
              '';
          };

          sources = [
            {
              name = "luasnip";
              max_item_count = 3;
              group_index = 1;
            }
            {
              name = "nvim_lsp";
              group_index = 1;
            }
            {
              name = "buffer";
              keyword_length = 2;
              max_item_count = 5;
              group_index = 2;
            }
            {
              name = "path";
              max_item_count = 3;
              group_index = 3;
            }
            {name = "nvim_lsp_signature_help";}
          ];

          window = {
            completion.__raw = "cmp.config.window.bordered()";
            documentation.__raw = "cmp.config.window.bordered()";
          };

          mapping = {
            "<CR>" =
              # lua
              ''
                -- Do not confirm for signature help to allow for inserting
                -- new lines without selecting the argument name
                cmp.sync(function(fallback)
                  local entry = cmp.core.view:get_selected_entry()
                  if entry and entry.source.name == "nvim_lsp_signature_help" then
                    fallback()
                  else
                    cmp.mapping.confirm({
                      behavior = cmp.ConfirmBehavior.Replace,
                      select = false,
                    })(fallback)
                  end
                end)

              '';
            "<C-c>" = "cmp.mapping.abort()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete({})";
            "<Down>" = "cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'})";
            "<Up>" = "cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'})";
            "<PageDown>" = "cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select, count = -10 }), {'i'})";
            "<PageUp>" = "cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select, count = 10 }), {'i'})";
            "<Tab>" =
              # lua
              ''
                cmp.mapping(function(fallback)
                  if cmp.visible() then
                    cmp.select_next_item()
                  elseif require("luasnip").expandable() then
                    require("luasnip").expand()
                  elseif require("luasnip").expand_or_locally_jumpable() then
                    require("luasnip").expand_or_jump()
                  else
                    fallback()
                  end
                end, {"i", "s"})
              '';
            "<S-Tab>" =
              # lua
              ''
                cmp.mapping(function(fallback)
                  if cmp.visible() then
                    cmp.select_prev_item()
                  elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                  else
                    fallback()
                  end
                end, {"i", "s"})
              '';
          };
        };
      };
    };
  };
}
