{
  programs.nixvim = {
    plugins.which-key = {
      enable = true;
      settings = {
        icons = {
          breadcrumb = "»";
          group = "+";
          separator = ""; # ➜
        };
        preset = "modern";
        spec = [
          {
            __unkeyed = "<leader>x";
            mode = "n";
            group = " Trouble";
          }
        ];
      };
    };
  };
}
