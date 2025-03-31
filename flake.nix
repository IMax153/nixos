{
  description = "My personal Nix configuration";

  inputs = {
    aider = {
      url = "github:matko/aider-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    nixvim = {
      url = "github:IMax153/nixvim";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    inputs@{ devshell, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        devshell.flakeModule
        ./darwin/flake-module.nix
        ./pkgs/flake-module.nix
      ];

      systems = [ "aarch64-darwin" ];

      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        {
          devshells.default =
            { extraModulesPath, ... }:
            {
              # `extraModulesPath` provides access to additional modules that are
              # not included in the standard devshell modules list.
              #
              # Please see https://numtide.github.io/devshell/extending.html for
              # documentation on consuming extra modules, and see
              # https://github.com/numtide/devshell/tree/main/extra for the
              # extra modules that are currently available.
              imports = [ "${extraModulesPath}/git/hooks.nix" ];

              git.hooks.enable = false;
              git.hooks.pre-commit.text = ''
                echo 1>&2 'time to implement a pre-commit hook!'
                exit 1
              '';

              packages = with pkgs; [
                age
                findutils
                sops
                ssh-to-age
                yq-go
              ];
            };
        };

      flake = {
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.
      };
    };
}
