{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  username = "emzy";
in {
  imports = [(lib.mkAliasOptionModule ["hm"] ["home-manager" "users" username])];

  users.users.emzy = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.fish;
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    overwriteBackup = true;
    users = {
      "${username}" = import ../hosts/${config.networking.hostName}/home.nix;
    };
  };
}
