{
  config,
  pkgs,
  ...
}: let
  tfenvConfigFile = "${config.xdg.configHome}/tfenv";

  # `tfenv` uses `$(which ggrep)` on MacOS if Homebrew is installed to determine
  # if the GNU version of `grep` is installed, so we need this hack to make
  # GNU grep available as `ggrep` on the machine
  grep = "${pkgs.runCommand "ggrep" {} ''
    mkdir -p $out/bin
    ln -sf ${pkgs.gnugrep}/bin/grep $out/bin/grep
    ln -sf ${pkgs.gnugrep}/bin/grep $out/bin/ggrep
  ''}";

  tfenv = pkgs.fetchFromGitHub {
    owner = "tfutils";
    repo = "tfenv";
    rev = "v3.0.0";
    sha256 = "sha256-2Fpaj/UQDE7PNFX9GNr4tygvKmm/X0yWVVerJ+Y6eks=";
  };
in {
  home.packages = [grep tfenv];

  home.sessionVariables = {
    TFENV_CONFIG_DIR = tfenvConfigFile;
  };
}
