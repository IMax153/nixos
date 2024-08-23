{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.nixvim = {
    extraPackages = with pkgs; [
      # eslint_d
      selene
      statix
    ];

    # Linting
    # https://nix-community.github.io/nixvim/plugins/lint/index.html
    plugins.lint = {
      enable = true;

      # NOTE: Enabling these will cause errors unless these tools are installed
      lintersByFt = {
        # javascript = ["eslint_d"];
        # javascriptreact = ["eslint_d"];
        lua = ["selene"];
        nix = ["statix"];
        # typescript = ["eslint_d"];
        # typescriptreact = ["eslint_d"];
      };

      # Create autocommand which carries out the actual linting
      # on the specified events.
      autoCmd = {
        callback.__raw = ''
          function()
            require('lint').try_lint()
          end
        '';
        group = "lint";
        event = [
          "BufEnter"
          "BufWritePost"
          "InsertLeave"
          "TextChanged"
          "TextChangedI"
        ];
      };
    };

    # https://nix-community.github.io/nixvim/NeovimOptions/autoGroups/index.html
    autoGroups = {
      lint = {
        clear = true;
      };
    };
  };
}
