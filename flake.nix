{
  description = "Maxwell Brown's Nix / NixOS system configurationss";

  inputs = {
    # Package Sets
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";

    # Environment / System Management
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Home Manager Modules
    nix-colors.url = "github:misterio77/nix-colors";

    # Development
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    darwin,
    home-manager,
    nixpkgs,
    pre-commit-hooks,
    treefmt-nix,
    ...
  }: let
    inherit (nixpkgs.lib) attrValues genAttrs optionalAttrs;

    defaultModules = [
      home-manager.darwinModules.home-manager
      {
        _module.args.self = self;
        _module.args.inputs = inputs;
      }
    ];

    nixpkgsDefaults = {
      config = {
        allowUnfree = true;
      };
    };

    systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    eachSystem = f: genAttrs systems (system: f nixpkgs.legacyPackages.${system});

    treefmtEval = eachSystem (pkgs: treefmt-nix.lib.evalModule pkgs ./treefmt.nix);
  in {
    ##############################################################################
    # Checks
    ##############################################################################
    checks = eachSystem (pkgs: {
      pre-commit = pre-commit-hooks.lib.${pkgs.system}.run (import ./pre-commit.nix);
      treefmt = treefmtEval.${pkgs.system}.config.build.check self;
    });

    ##############################################################################
    # Formatting
    ##############################################################################
    formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);

    ##############################################################################
    # Overlays
    ##############################################################################
    overlays = {
      pkgs-master = _: prev: {
        pkgs-master = import inputs.nixpkgs-master {
          inherit (prev.stdenv) system;
          inherit (nixpkgsDefaults) config;
        };
      };

      pkgs-stable = _: prev: {
        pkgs-stable = import inputs.nixpkgs-stable {
          inherit (prev.stdenv) system;
          inherit (nixpkgsDefaults) config;
        };
      };

      pkgs-unstable = _: prev: {
        pkgs-unstable = import inputs.nixpkgs {
          inherit (prev.stdenv) system;
          inherit (nixpkgsDefaults) config;
        };
      };

      apple-silicon = _: prev:
        optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
          # Add access to x86 packages system is running Apple Silicon
          pkgs-x86 = import inputs.nixpkgs {
            system = "x86_64-darwin";
            inherit (nixpkgsDefaults) config;
          };
        };
    };

    ##############################################################################
    # Modules
    ##############################################################################
    commonModules = attrValues (import ./modules/common);
    darwinModules = attrValues (import ./modules/darwin);
    homeManagerModules = attrValues (import ./modules/home);

    ##############################################################################
    # Machines
    ##############################################################################
    darwinConfigurations = {
      mbp = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules =
          defaultModules
          ++ self.commonModules
          ++ self.darwinModules
          ++ [
            ./hosts/mbp/configuration.nix
          ];
      };
    };

    devShells = eachSystem (pkgs: {
      default = import ./shell.nix {inherit pkgs self;};
    });
  };
}
