{pkgs, ...}:
with pkgs.vscode-extensions;
  [
    dbaeumer.vscode-eslint
    foxundermoon.shell-format
    jnoortheen.nix-ide
    mads-hartmann.bash-ide-vscode
    mkhl.direnv
    ms-python.python
    ms-python.vscode-pylance
    ms-vscode-remote.remote-ssh
    redhat.vscode-yaml
    timonwong.shellcheck
    unifiedjs.vscode-mdx
    vscodevim.vim
    yzhang.markdown-all-in-one
  ]
  ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "effect-vscode";
      publisher = "effectful-tech";
      version = "0.0.2";
      sha256 = "sha256-4DVSffwCISPD2nnsppv4l1QB9G67MnD2MklJKDC/EFQ=";
    }
    {
      name = "vscode-icons";
      publisher = "vscode-icons-team";
      version = "12.7.0";
      sha256 = "sha256-q0PS5nSQNx/KUpl+n2ZLWtd3NHxGEJaUEUw4yEB7YPA=";
    }
    {
      name = "vscode-theme-onedark";
      publisher = "akamud";
      version = "2.3.0";
      sha256 = "sha256-8GGv4L4poTYjdkDwZxgNYajuEmIB5XF1mhJMxO2Ho84=";
    }
  ]
