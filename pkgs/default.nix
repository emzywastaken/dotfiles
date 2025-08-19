{pkgs, ...}: let
  inherit (pkgs) callPackage;
in {
  spotify = callPackage ./spotify-spotx.nix {};
  sddm-sugar-dark = callPackage ./sddm-sugar-dark.nix {};
}
