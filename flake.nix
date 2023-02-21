{
  description = "Maxwell Brown's NixOS Configuration";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-22.11";
    };

    nixpkgs-darwin = {
      url = "github:NixOS/nixpkgs/nixpkgs-22.11-darwin";
    };

    nixpkgs-master = {
      url = "github:NixOS/nixpkgs/master";
    };

    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors = {
      url = "github:misterio77/nix-colors";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-darwin,
    nixpkgs-unstable,
    darwin,
    deploy-rs,
    home-manager,
    ...
  }: let
    supportedSystems = [
      "x86_64-linux"
      "aarch64-darwin"
      "aarch64-linux"
    ];

    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    pkgsFor = system: nixpkgs.legacyPackages.${system};

    inherit (self) outputs;
    specialArgs = {inherit inputs outputs;};
  in {
    homeManagerModules = import "${self}/modules/home-manager";

    formatter = forAllSystems (
      system: let
        pkgs = pkgsFor system;
      in
        pkgs.alejandra
    );

    devShells = forAllSystems (system: let
      pkgs = pkgsFor system;
    in {
      default = pkgs.callPackage "${self}/shell.nix" {inherit pkgs;};
    });

    overlays = import "${self}/overlays";

    darwinConfigurations = {
      # darwin-rebuild switch --flake .#$(hostname -s)
      mbp2021 = darwin.lib.darwinSystem {
        inherit specialArgs;
        inputs = nixpkgs.lib.overrideExisting inputs {nixpkgs = nixpkgs-darwin;};
        modules = ["${self}/hosts/mbp2021"];
      };
    };

    nixosConfigurations = {
      # deploy .#homepi
      homepi = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = ["${self}/hosts/homepi"];
      };
    };

    deploy = {
      nodes = {
        homepi = {
          hostname = "homepi";
          profiles = {
            system = {
              sshUser = "root";
              path = deploy-rs.lib.aarch64-linux.activate.nixos self.nixosConfigurations.homepi;
            };
          };
        };
      };
    };
  };
}
