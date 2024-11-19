let
  inherit (import ./keymap-utils.nix) nnoremap tnoremap vnoremap;
in
{
  programs.nixvim = {
    keymaps = [
      ##########################################################################
      # General Keymaps
      ##########################################################################

      # Disabled Keys
      (nnoremap "<space>" "<nop>" "Disable Space Bar")

      # Movement
      (nnoremap "L" "$" "Jump End of [L]ine")
      (nnoremap "H" "^" "Jump Start of [L]ine")
      (nnoremap "j" "jzz" "Vertically Center Cursor Down")
      (nnoremap "k" "kzz" "Vertically Center Cursor Up")
      (nnoremap "gg" "ggzz" "Vertically Center Cursor Start Of File")
      (nnoremap "G" "Gzz" "Vertically Center Cursor End Of File")

      # Redo
      (nnoremap "U" "<C-r>" "Redo")

      # Save Buffer
      (nnoremap "<C-s>" "<cmd>w<cr>" "Save Current Buffer")

      # Turn off highlighted results
      (nnoremap "<leader>no" "<cmd>noh<cr>" "[N]o Highlight")

      # Quickfix List
      (nnoremap "<leader>cn" "<cmd>cnext<cr>zz" "[N]ext Quickfix List Item")
      (nnoremap "<leader>cp" "<cmd>cprevious<cr>zz" "[P]revious Quickfix List Item")
      (nnoremap "<leader>co" "<cmd>copen<cr>zz" "[O]pen Quickfix List")
      (nnoremap "<leader>cc" "<cmd>cclose<cr>zz" "[C]lose Quickfix List")

      # Tab Management
      (nnoremap "<leader><tab>f" "<cmd>tabfirst<cr>" "First Tab")
      (nnoremap "<leader><tab><tab>" "<cmd>tabnew<cr>" "New Tab")
      (nnoremap "<leader><tab>[" "<cmd>tabprevious<cr>" "Previous Tab")
      (nnoremap "<leader><tab>]" "<cmd>tabnext<cr>" "Next Tab")
      (nnoremap "<leader><tab>d" "<cmd>tabclose<cr>" "Close Tab")

      # Window Management
      (nnoremap "<leader>w-" "<C-w>s" "Split [W]indow Vertical")
      (nnoremap "<leader>w|" "<C-w>v" "Split [W]indow Horizontal")
      (nnoremap "<leader>wd" "<C-w>c" "Delete [W]indow")
      (nnoremap "<leader>=" "<C-w>=" "Resize Windows Equal")
      (nnoremap "<C-j>" {
        __raw =
          # lua
          ''
            function()
              if vim.fn.exists(":NvimTmuxNavigateDown") ~= 0 then
                vim.cmd.NvimTmuxNavigateDown()
              else
                vim.cmd.wincmd("j")
              end
            end
          '';
      } "Navigate Window Down")
      (nnoremap "<C-k>" {
        __raw =
          # lua
          ''
            function()
              if vim.fn.exists(":NvimTmuxNavigateUp") ~= 0 then
                vim.cmd.NvimTmuxNavigateUp()
              else
                vim.cmd.wincmd("k")
              end
            end
          '';
      } "Navigate Window Up")
      (nnoremap "<C-h>" {
        __raw =
          # lua
          ''
            function()
              if vim.fn.exists(":NvimTmuxNavigateLeft") ~= 0 then
                vim.cmd.NvimTmuxNavigateLeft()
              else
                vim.cmd.wincmd("h")
              end
            end
          '';
      } "Navigate Window Left")
      (nnoremap "<C-l>" {
        __raw =
          # lua
          ''
            function()
              if vim.fn.exists(":NvimTmuxNavigateRight") ~= 0 then
                vim.cmd.NvimTmuxNavigateRight()
              else
                vim.cmd.wincmd("l")
              end
            end
          '';
      } "Navigate Window Right")

      # Rebind Escape
      {
        mode = "i";
        key = "jj";
        action = "<Esc>";
        options = {
          desc = "Exit Insert Mode";
          nowait = true;
        };
      }

      # Save and Quit
      {
        mode = "n";
        key = "<leader>w";
        action = "<cmd>w<cr>";
        options = {
          desc = "[W]rite Buffer";
          silent = false;
        };
      }
      {
        mode = "n";
        key = "<leader>q";
        action = "<cmd>q<cr>";
        options = {
          desc = "[Q]uit Buffer";
          silent = false;
        };
      }
      {
        mode = "n";
        key = "<leader>z";
        action = "<cmd>wq<cr>";
        options = {
          desc = "[W]rite [Q]uit Buffer";
          silent = false;
        };
      }

      (vnoremap "<" "<gv" "Visual Mode Outdent")
      (vnoremap ">" ">gv" "Visual Mode Indent")

      ##########################################################################
      # Terminal Keymaps
      ##########################################################################
      (tnoremap "jj" "[[<C-\\><C-n>]]" "Enter Normal Mode (Terminal)")
      (tnoremap "<Esc>" "[[<C-\><C-n>]]" "Enter Normal Mode (Terminal)")

      (tnoremap "<C-h>" "[[<cmd>wincmd h<cr>]]" "Terminal Window Left")
      (tnoremap "<C-j>" "[[<cmd>wincmd j<cr>]]" "Terminal Window Down")
      (tnoremap "<C-k>" "[[<cmd>wincmd k<cr>]]" "Terminal Window Up")
      (tnoremap "<C-l>" "[[<cmd>wincmd l<cr>]]" "Terminal Window Right")

      # Prevent input delay on space
      (tnoremap "<space>" "<space>" "Default Space Functionality")

      ##########################################################################
      # Plugin Keymaps
      ##########################################################################

      # Conform
      (nnoremap "<leader>f" {
        __raw =
          # lua
          ''
            function()
              require("conform").format({
                async = true,
                timeout_ms = 500,
                lsp_format = "fallback",
              })
            end
          '';
      } "[F]ormat Current Buffer")

      # Harpoon
      (nnoremap "<leader>ho" "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>" "[H]arpoon [O]pen")
      (nnoremap "<leader>ha" "<cmd>lua require('harpoon.mark').add_file()<cr>"
        "[H]arpoon [A]dd Current File"
      )
      (nnoremap "<leader>hr" "<cmd>lua require('harpoon.mark').rm_file()<cr>"
        "[H]arpoon [R]emove Current File"
      )
      (nnoremap "<leader>hc" "<cmd>lua require('harpoon.mark').clear_all()<cr>" "[H]arpoon [C]lear")
      (nnoremap "<leader>h1" "<cmd>lua require('harpoon.ui').nav_file(1)<cr>" "[H]arpoon File [1]")
      (nnoremap "<leader>h2" "<cmd>lua require('harpoon.ui').nav_file(2)<cr>" "[H]arpoon File [2]")
      (nnoremap "<leader>h3" "<cmd>lua require('harpoon.ui').nav_file(3)<cr>" "[H]arpoon File [3]")
      (nnoremap "<leader>h4" "<cmd>lua require('harpoon.ui').nav_file(4)<cr>" "[H]arpoon File [4]")
      (nnoremap "<leader>h5" "<cmd>lua require('harpoon.ui').nav_file(5)<cr>" "[H]arpoon File [5]")

      # Oil
      (nnoremap "<leader>e" "<cmd>Oil --float<cr>" "Open Oil")

      # Spectre
      (nnoremap "<leader>S" "<cmd>lua require('spectre').toggle()<cr>" "Toggle [S]pectre")
      (nnoremap "<leader>sw" "<cmd>lua require('spectre').open_visual({ select_word = true })<cr>"
        "[S]earch Current [W]ord"
      )
      (vnoremap "<leader>sw" "<cmd>lua require('spectre').open_visual()<cr>" "[S]earch Current [W]ord")

      # Telescope
      (nnoremap "<leader>sb" "<cmd>Telescope buffers<cr>" "[S]earch Open [B]uffers")
      (nnoremap "<leader>sf" "<cmd>Telescope find_files hidden=true<cr>" "[S]earch [K]eymaps")
      (nnoremap "<leader>sg" "<cmd>Telescope live_grep<cr>" "[S]earch [G]rep")
      (nnoremap "<leader>sh" "<cmd>Telescope help_tags<cr>" "[S]earch [H]elp")
      (nnoremap "<leader>sk" "<cmd>Telescope keymaps<cr>" "[S]earch [K]eymaps")
      (nnoremap "<leader>sr" "<cmd>Telescope oldfiles<cr>" "[S]earch [R]ecent Files")
      (nnoremap "<leader>st" "<cmd>Telescope builtin<cr>" "[S]earch [T]elescope")
      (nnoremap "<leader>sc" {
        __raw =
          # lua
          ''
            function()
              require("telescope.builtin").commands(
                require("telescope.themes").get_dropdown({
                  previewer = false,
                })
              )
            end
          '';
      } "[S]earch [C]ommands")
      (nnoremap "<leader>/" {
        __raw =
          # lua
          ''
            function()
              require("telescope.builtin").current_buffer_fuzzy_find(
                require("telescope.themes").get_dropdown({
                  previewer = false,
                })
              )
            end
          '';
      } "[/] Fuzzily Search Current Buffer")

      # Trouble
      (nnoremap "<leader>xx" "<cmd>Trouble preview_split toggle<cr>" "[T]rouble Diagnostics Toggle")
      (nnoremap "<leader>xX" "<cmd>Trouble preview_split toggle filter.buf=0<cr>"
        "[T]rouble Buffer Diagnostics Toggle"
      )
      (nnoremap "<leader>xd" "<cmd>Trouble lsp_definitions toggle focus=false<cr>"
        "[T]rouble LSP Definitions Toggle"
      )
      (nnoremap "<leader>xD" "<cmd>Trouble lsp_declarations toggle focus=false<cr>"
        "[T]rouble LSP Declarations Toggle"
      )
      (nnoremap "<leader>xi" "<cmd>Trouble lsp_implementations toggle focus=false<cr>"
        "[T]rouble LSP Implementations Toggle"
      )
      (nnoremap "<leader>xt" "<cmd>Trouble lsp_type_definitions toggle focus=false<cr>"
        "[T]rouble LSP Type Definitions Toggle"
      )
      (nnoremap "<leader>xr" "<cmd>Trouble lsp_references toggle focus=false<cr>"
        "[T]rouble LSP References Toggle"
      )
    ];
  };
}
