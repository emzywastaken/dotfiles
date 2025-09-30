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
        type = with types; either (listOf str) (functionTo (listOf str));
        default = lib.const [];
        description = ''
          Extra commands to add to `exec-once` or an overriding function.
          Can be provided either as a list of strings added to `exec-once`
          or as a function that takes in the default command list and returns a new list.
        '';
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
      settings = let
        default = [
          "waybar"
          "hyprctl setcursor ${config.home.pointerCursor.name} ${toString config.home.pointerCursor.size}"
        ];
      in {
        monitor = ",preferred,auto,${toString cfg.monitorScale}";
        exec-once =
          if lib.isFunction cfg.startupCommands
          then cfg.startupCommands default
          else default ++ cfg.startupCommands;

        "$mainMod" = "SUPER";
        bind = [
          # Togge waybar
          "$mainMod, B, exec, pkill waybar || waybar"
        ];
      };
      extraConfig = concatLines [
        cfg.extraConfig
        (readFile ./hyprland.conf)
      ];
    };

    services.swww.enable = true;
    home.packages = [
      pkgs.waybar
    ];
  };
}
