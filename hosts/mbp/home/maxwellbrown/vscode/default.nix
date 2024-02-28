{pkgs, ...}: {
  home.packages = with pkgs; [alejandra nil];
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    mutableExtensionsDir = false;
    extensions = import ./extensions.nix {inherit pkgs;};
    languageSnippets = import ./language-snippets.nix;
    userSettings = import ./settings.nix {inherit pkgs;};
  };
}
