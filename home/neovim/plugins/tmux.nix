{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimUtils; [
      (buildVimPlugin {
        pname = "nvim-tmux-navigation";
        version = "1.1.0";
        src = pkgs.fetchFromGitHub {
          owner = "alexghergh";
          repo = "nvim-tmux-navigation";
          rev = "4898c98702954439233fdaf764c39636681e2861";
          sha256 = "sha256-CxAgQSbOrg/SsQXupwCv8cyZXIB7tkWO+Y6FDtoR8xk=";
        };
      })
    ];

    extraConfigLua = ''
      require('nvim-tmux-navigation').setup({
        disable_when_zoomed = true,
      })
    '';
  };
}
