{
  pkgs,
  inputs,
  ...
}: let
  importDir = dir: map (file: "${toString dir}/${file}") (builtins.attrNames (builtins.readDir dir));
in {
  imports =
    [
      ./boot.nix
      ./fonts.nix
      ./users.nix
    ]
    ++ importDir ./services
    ++ importDir ./apps
    ++ importDir ./wms
    ++ importDir ./hardware;

  networking.networkmanager.enable = true;

  time.timeZone = "Africa/Lagos";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  nixpkgs.config.allowUnfree = true;
  nix = {
    settings = {
      extra-substituters = [
        "https://nix-community.cachix.org"
      ];

      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      experimental-features = ["nix-command" "flakes"];
    };
    # nixd aksed for this
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    package = pkgs.nixVersions.latest;
  };
  system.stateVersion = "24.11";
}
