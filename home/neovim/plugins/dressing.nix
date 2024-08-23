{
  programs.nixvim = {
    plugins.dressing = {
      enable = true;
      settings = {
        builtin = {
          border = "rounded";
        };
        input = {
          enabled = true;
          border = "rounded";
        };
        select = {
          enabled = true;
          backend = [
            "telescope"
            "fzf_lua"
            "fzf"
            "builtin"
            "nui"
          ];
        };
      };
    };
  };
}
