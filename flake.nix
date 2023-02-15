{
  description = "Maxwell Brown's NixOS Configuration";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-22.11";
    };

    nixpkgs-darwin = {
      url = "github:NixOS/nixpkgs/nixpkgs-22.11-darwin";
    };

    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
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
    home-manager,
    ...
  }: let
    supportedSystems = [
      "x86_64-darwin"
      "x86_64-linux"
      "aarch64-darwin"
      "aarch64-linux"
    ];

    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    pkgsFor = system: nixpkgs.legacyPackages.${system};

    inherit (self) outputs;
    specialArgs = {inherit inputs outputs;};
  in {
    homeManagerModules = import "${self}/nix/modules/home-manager";

    formatter = forAllSystems (
      system: let
        pkgs = pkgsFor system;
      in
        pkgs.alejandra
    );

    # devShells = forAllSystems (system:
    #   let pkgs = pkgsFor system;
    #   in {
    #     default = pkgs.callPackage ./shell.nix { inherit pkgs; };
    #   });
    # devShells = forAllSystems (system: {
    #   default = nixpkgsFor.${system}.mkShell {
    #     buildInputs = with nixpkgsFor.${system}; [
    #     ];
    #   };
    # });

    darwinConfigurations = {
      # darwin-rebuild switch --flake .#$(hostname -s)
      mbp2021 = darwin.lib.darwinSystem {
        inherit specialArgs;
        inputs = nixpkgs.lib.overrideExisting inputs {nixpkgs = nixpkgs-darwin;};
        modules = ["${self}/nix/hosts/mbp2021"];
      };
    };
  };
}
