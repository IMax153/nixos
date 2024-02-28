{
  src = ./.;

  settings = {};

  hooks = {
    alejandra.enable = true;
    deadnix.enable = true;
    shellcheck.enable = true;
    shellcheck.excludes = ["\.zsh$"];
  };
}
