{
  programs.nixvim = let
    javascriptOpts = {
      extraConfigVim =
        # vimscript
        ''
          " Disable inserting comment leader after pressing 'o' or 'O'
          set formatoptions-=o
        '';
    };
  in {
    files = {
      "after/ftplugin/javascript.vim" = javascriptOpts;
      "after/ftplugin/typescript.vim" = javascriptOpts;
    };
  };
}
