{
  inputs,
  self,
  ...
}: {
  flake.darwinConfigurations.heimdall = inputs.nix-darwin.lib.darwinSystem {
    modules = [./machines/heimdall/configuration.nix];
    specialArgs = {inherit inputs self;};
  };
}
