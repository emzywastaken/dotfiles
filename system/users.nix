{
  pkgs,
  config,
  inputs,
  ...
}: {
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
      "emzy" = import ../hosts/${config.networking.hostName}/home.nix;
    };
  };
}
