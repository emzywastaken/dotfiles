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
      enable = mkEnableOption "hyprland";
      monitorScale = mkOption {
        type = types.either types.float types.str;
        default = "auto";
        description = "Monitor scaling";
      };
      startupCommands = mkOption {
        type = types.listOf types.str;
        default = [];
        description = "commands to be added to exec-once";
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
        exec-once =
          # TODO: use services
          [
            "swww-daemon"
            "waybar"
            "nm-applet"
            "dunst"
            "hyprctl setcursor ${config.home.pointerCursor.name} ${toString config.home.pointerCursor.size}"
          ]
          ++ cfg.startupCommands;
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
