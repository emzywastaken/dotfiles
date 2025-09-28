{
  pkgs,
  config,
  inputs,
  ...
}: {
  users.users.emzy = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    users = {
      "emzy" = import ../hosts/${config.networking.hostName}/home.nix;
    };
  };
}
