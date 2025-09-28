{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.grub;
in {
  options.modules = {
    grub.enable = lib.mkEnableOption "Enable grub";
  };
  config = lib.mkIf cfg.enable {
    boot = {
      loader.grub.enable = true;
      loader.grub.device = "nodev";
      loader.grub.splashImage = null;
      loader.grub.efiSupport = true;
      loader.grub.efiInstallAsRemovable = true;
      kernelParams = ["mem_sleep_default=s2idle"];
      kernelPackages = pkgs.linuxPackages_zen;
    };
  };
}
