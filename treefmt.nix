{pkgs, ...}: {
  # Used to find the project root
  projectRootFile = "flake.nix";

  # programs = {
  #   terraform = {
  #     enable = true;
  #   };
  # };

  settings.formatter = {
    nix = {
      command = "${pkgs.bash}/bin/bash";
      options = [
        "-euc"
        ''
          export PATH=${pkgs.lib.makeBinPath [pkgs.coreutils pkgs.findutils pkgs.deadnix pkgs.alejandra]}
          deadnix --edit "$@"
          alejandra "$@"
        ''
        "--" # bash swallows the second argument when using -c
      ];
      includes = ["*.nix"];
      excludes = [""];
    };

    shell = {
      command = "${pkgs.bash}/bin/bash";
      options = [
        "-euc"
        ''
          # First shellcheck
          ${pkgs.lib.getExe pkgs.shellcheck} --external-sources --source-path=SCRIPTDIR "$@"
          # Then format
          ${pkgs.lib.getExe pkgs.shfmt} -i 2 -s -w "$@"
        ''
        "--" # bash swallows the second argument when using -c
      ];
      includes = ["*.sh"];
      excludes = ["nixos/modules/k3s/k3s-reset-node"];
    };

    python = {
      command = "${pkgs.bash}/bin/bash";
      options = [
        "-euc"
        ''
          ${pkgs.lib.getExe pkgs.ruff} --fix "$@"
          ${pkgs.lib.getExe pkgs.python3.pkgs.black} "$@"
        ''
        "--" # bash swallows the second argument when using -c
      ];
      includes = ["*.py"];
      excludes = [
        "gdb/*"
        "zsh/*"
      ];
    };

    yaml = {
      command = "${pkgs.bash}/bin/bash";
      options = [
        "-euc"
        ''
          for file in "$@"; do
            ${pkgs.lib.getExe pkgs.yq-go} -i $file
          done
        ''
        "--" # bash swallows the second argument when using -c
      ];
      includes = ["*.yaml"];
    };
  };
}
