{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    silent-sddm = {
      url = "github:/uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, ...} @ inputs: let
    system = "x86_64-linux";
    mkSystem = hostname:
      nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/${hostname}
          ./overlays
          ./system
          inputs.home-manager.nixosModules.default
        ];
      };
  in {
    nixosConfigurations.aje = mkSystem "aje";

    nixosConfigurations.ink = mkSystem "ink";

    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
  };
}
