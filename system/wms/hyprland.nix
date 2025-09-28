{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.wms.hyprland;
in {
  options = {
    modules.wms.hyprland = {
      enable = lib.mkEnableOption "hyprland";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
}
