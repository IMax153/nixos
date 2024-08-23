{
  programs.nixvim = {
    autoCmd = [
      {
        desc = "Highlight on yank";
        event = ["TextYankPost"];
        callback = {
          __raw =
            # lua
            ''
              function()
                vim.highlight.on_yank()
              end
            '';
        };
      }
    ];
  };
}
