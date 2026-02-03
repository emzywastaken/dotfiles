{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  users.users.emzy = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.fish;
  };
}
