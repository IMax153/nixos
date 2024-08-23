{pkgs, ...}: {
  home.packages = with pkgs; [ripgrep];

  programs.nixvim = {
    plugins.telescope = {
      enable = true;

      extensions = {
        fzf-native.enable = true;
        ui-select.enable = true;
      };

      settings = {
        extensions.__raw =
          # lua
          ''
            { ["ui-select"] = { require("telescope.themes").get_dropdown() } }
          '';

        defaults.file_ignore_patterns = [
          ".git"
          ".next"
          "node_modules"
          "build"
          "dist"
          "yarn.lock"
          "pnpm-lock.yaml"
        ];

        # Setup default key mappings
        defaults.mappings = {
          n = {
            q = {
              __raw = "require('telescope.actions').close";
            };
            "-" = {
              __raw = "require('telescope.actions').select_horizontal";
            };
            "|" = {
              __raw = "require('telescope.actions').select_vertical";
            };
          };
        };

        # Enable previewing color schemes prior to selection
        pickers.colorscheme.enable_preview = true;
      };

      keymaps = {
        "<leader>gs" = {
          mode = "n";
          action = "git_status";
          options = {
            desc = "[G]it [S]tatus";
          };
        };
        "<leader>gb" = {
          mode = "n";
          action = "git_branches";
          options = {
            desc = "[G]it [B]ranches";
          };
        };
        "<leader>gc" = {
          mode = "n";
          action = "git_commits";
          options = {
            desc = "[G]it [C]ommits";
          };
        };
      };
    };
  };
}
