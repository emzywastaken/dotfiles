{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.niri;
in {
  options = {
    modules.niri.enable = lib.mkEnableOption "niri";
  };

  config = lib.mkIf cfg.enable {
    programs.niri.enable = true;

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-gnome];

    environment.systemPackages = [pkgs.xwayland-satellite];

    hj.xdg.config.files."niri/config.kdl".source = ./config.kdl;
  };
}
