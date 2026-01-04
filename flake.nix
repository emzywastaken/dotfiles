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

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
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
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.aje = mkSystem "aje";

    nixosConfigurations.ink = mkSystem "ink";

    packages.${system} = {
      wayland-debug = pkgs.callPackage ./pkgs/wayland-debug.nix {inherit (pkgs) python3Packages;};
    };

    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
  };
}
