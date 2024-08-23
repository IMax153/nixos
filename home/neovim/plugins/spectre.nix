{pkgs, ...}: let
  # If the `replace_engine` for Spectre is set to `sed`, Spectre will search
  # for `gsed` in the `PATH` on MacOS. Therefore, this hack is required to link
  # the GNU version of `sed` to the `gsed` executable.
  sed = "${pkgs.runCommand "gsed" {} ''
    mkdir -p $out/bin
    ln -sf ${pkgs.gnused}/bin/sed $out/bin/sed
    ln -sf ${pkgs.gnused}/bin/sed $out/bin/gsed
  ''}";
in {
  home.packages = [sed];

  programs.nixvim = {
    plugins.spectre = {
      enable = true;
      settings = {
        highlight = {
          search = "SpectreSearch";
          replace = "SpectreReplace";
        };
        replace_engine = {
          sed = {
            cmd = "sed";
            args = ["-i" "-E"];
          };
        };
      };
    };
  };
}
