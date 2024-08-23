{config, ...}: {
  programs.nixvim.plugins = {
    dashboard = {
      enable = true;
      settings = {
        hide = {tabline = false;};
        disable_move = true;
        theme = "hyper";
        config = {
          packages = {enable = false;};
          week_header.enable = true;
          footer = [" " " " "Build, break, improve, repeat."];
          project = {enable = false;};
          header = [
            "███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗"
            "████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║"
            "██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║"
            "██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║"
            "██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║"
            "╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
          ];
          shortcut = [
            {
              desc = "${config.nixvim.icons.ui.History} Recent Files";
              group = "String";
              key = "r";
              action = "Telescope oldfiles";
            }
            {
              desc = "${config.nixvim.icons.ui.Files} Find Files";
              group = "@variable";
              key = "f";
              action = "Telescope find_files";
            }
            {
              desc = " Last Session";
              group = "Number";
              key = ".";
              action = "SessionManager load_last_session";
            }
            {
              desc = " List Session";
              group = "DiagnosticHint";
              key = "l";
              action = "SessionManager load_session";
            }
            {
              desc = "${config.nixvim.icons.ui.BoldClose} Quit";
              group = "DiagnosticError";
              key = "q";
              action = "qa";
            }
          ];
        };
      };
    };
  };
}
