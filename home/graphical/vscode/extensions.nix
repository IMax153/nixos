{pkgs, ...}:
with pkgs.vscode-extensions;
  [
    dbaeumer.vscode-eslint
    esbenp.prettier-vscode
    foxundermoon.shell-format
    github.vscode-pull-request-github
    jnoortheen.nix-ide
    mads-hartmann.bash-ide-vscode
    mkhl.direnv
    # ms-python.python
    # ms-python.vscode-pylance
    ms-vscode-remote.remote-ssh
    redhat.vscode-yaml
    timonwong.shellcheck
    unifiedjs.vscode-mdx
    vscodevim.vim
    vscode-icons-team.vscode-icons
    yzhang.markdown-all-in-one
  ]
  ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "biome";
      publisher = "biomejs";
      version = "2.2.3";
      sha256 = "sha256-783SpqKjqBIKWDZ6CVC29FQy6ku+0p1fYe6l0TExrlQ=";
    }
    {
      name = "effect-vscode";
      publisher = "effectful-tech";
      version = "0.1.2";
      sha256 = "sha256-qeZrwmJxQzSFMhyjJA0Igi/4gmo2eNS6JiWG9xxe3bc=";
    }
    {
      name = "pretty-ts-errors";
      publisher = "yoavbls";
      version = "0.5.3";
      sha256 = "sha256-JSCyTzz10eoUNu76wNUuvPVVKq4KaVKobS1CAPqgXUA=";
    }
    {
      name = "vscode-theme-onedark";
      publisher = "akamud";
      version = "2.3.0";
      sha256 = "sha256-8GGv4L4poTYjdkDwZxgNYajuEmIB5XF1mhJMxO2Ho84=";
    }
  ]
