{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types concatLines;
  inherit (builtins) toString readFile;
  cfg = config.modules.hyprland;
in {
  options = {
    modules.hyprland = {
      enable = mkEnableOption "whether to enable hyprland";
      monitorScale = mkOption {
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
        monitor = ",preferred,auto,${toString cfg.monitorScale}";
        exec-once = [
          "swww-daemon"
          "waybar"
          "nm-applet"
          "dunst"
          "hyprctl setcursor ${config.home.pointerCursor.name} ${toString config.home.pointerCursor.size}"
        ];
      };
      extraConfig = concatLines [
        cfg.extraConfig
        (readFile ./hyprland.conf)
      ];
    };

    # services.swww.enable = true;
    home.packages = [
      pkgs.waybar
    ];
  };
}
