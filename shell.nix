{
  pkgs,
  self,
  ...
}:
pkgs.mkShellNoCC {
  # sopsPGPKeyDirs = ["./nixos/secrets/keys"];
  # sopsCreateGPGHome = true;
  nativeBuildInputs = [
    # inputs'.sops-nix.packages.sops-import-keys-hook

    pkgs.python3.pkgs.deploykit
    pkgs.python3.pkgs.invoke
  ];

  buildInputs = with pkgs; [
    # K8s
    kubernetes-helm
    kubectl
    # Python
    python3.pkgs.black
    ruff
    # SOPS
    age
    sops
    ssh-to-age
    # Utilities
    findutils
    jq
    rsync
    yq-go
  ];

  # Required because `nixos-rebuild` does not seem to respect `~/.ssh/config`
  # which means that on MacOS the Unix socket length for the SSH control
  # path is too long
  NIX_SSHOPTS = "-o ControlPath=/tmp/%r@%h:%p";

  # Ensure that SOPS uses Vim for editing secrets
  EDITOR = "vim";

  shellHook = ''
    ${self.checks.${pkgs.system}.pre-commit.shellHook}
  '';
}
