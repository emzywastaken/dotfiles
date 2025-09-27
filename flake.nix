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
  in {
    nixosConfigurations.aje = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/aje/configuration.nix
        ./overlays
        inputs.home-manager.nixosModules.default
      ];
    };

    nixosConfigurations.ink = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/ink/configuration.nix
        ./overlays
        inputs.home-manager.nixosModules.default
      ];
    };

    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
  };
}
