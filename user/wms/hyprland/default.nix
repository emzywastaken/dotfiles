{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types;
  inherit (builtins) toString readFile;
  cfg = config.modules.hyprland;
in {
  options = {
    modules.hyprland = {
      enable = mkEnableOption "whether to enable hyprland";
      monitor.scale = mkOption {
        type = types.either types.float types.str;
        default = "auto";
        description = "Monitor scaling";
      };
      extraConfig = mkOption {
        type = types.lines;
        default = "";
        description = "Extra configuration lins to add to config";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        monitor = ",preferred,auto,${toString cfg.monitor.scale}";
      };
      extraConfig = cfg.extraConfig + (readFile ./hyprland.conf);
    };
  };
}
