{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types;
  cfg = config.modules.hyprland;
in {
  imports = [
    ./keybinds.nix
  ];

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
    modules.waybar = lib.mkDefault {
      enable = true;
    };

    wayland.windowManager.hyprland = {
      enable = true;
      settings = let
        default-execs = [
          "waybar"
          "hyprctl setcursor ${config.home.pointerCursor.name} ${toString config.home.pointerCursor.size}"
        ];
      in {
        monitor = ",preferred,auto,${toString cfg.monitorScale}";
        exec-once =
          if lib.isFunction cfg.startupCommands
          then cfg.startupCommands default-execs
          else default-execs ++ cfg.startupCommands;

        general = {
          gaps_in = 5;
          gaps_out = 20;
          border_size = 2;
          "col.active_border" = "rgb(d5c4a1)";
          "col.inactive_border" = "rgba(595959aa)";
          resize_on_border = true;
          allow_tearing = true;
          layout = "dwindle";
        };

        decoration = {
          rounding = 10;
          rounding_power = 2;
          active_opacity = 1.0;
          inactive_opacity = 1.0;

          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "rgba(1a1a1aee)";
          };

          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };

        animations = {
          enabled = "yes";
          bezier = [
            "easeOutQuint, 0.23, 1, 0.32, 1"
            "easeInOutCubic, 0.65, 0.05, 0.36, 1"
            "linear, 0, 0, 1, 1"
            "almostLinear, 0.5, 0.5, 0.75, 1.0"
            "quick, 0.15, 0, 0.1, 1"
          ];

          animation = [
            "global, 1, 10, default"
            "border, 1, 5.39, easeOutQuint"
            "windows, 1, 4.79, easeOutQuint"
            "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
            "windowsOut, 1, 1.49, linear, popin 87%"
            "fadeIn, 1, 1.73, almostLinear"
            "fadeOut, 1, 1.46, almostLinear"
            "fade, 1, 3.03, quick"
            "layers, 1, 3.81, easeOutQuint"
            "layersIn, 1, 4, easeOutQuint, fade"
            "layersOut, 1, 1.5, linear, fade"
            "fadeLayersIn, 1, 1.79, almostLinear"
            "fadeLayersOut, 1, 1.39, almostLinear"
            "workspaces, 1, 1.94, almostLinear, fade"
            "workspacesIn, 1, 1.21, almostLinear, fade"
            "workspacesOut, 1, 1.94, almostLinear, fade"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        master = {
          new_status = "master";
        };

        misc = {
          force_default_wallpaper = -1;
          disable_hyprland_logo = true;
        };

        input = {
          kb_layout = "us";
          follow_mouse = 1;
          accel_profile = "flat";

          # -1.0 - 1.0, 0 means no modification.
          sensitivity = 0;

          touchpad = {
            disable_while_typing = true;
            natural_scroll = true;
            scroll_factor = 0.3;
            # drag_lock = true
          };
        };

        gestures = {
          # https://wiki.hyprland.org/Configuring/Variables/#gestures
          gesture = "3, horizontal, workspace";
        };

        binds = {
          workspace_back_and_forth = true;
        };

        debug = {
          full_cm_proto = true;
        };

        windowrule = [
          "float, class:xdg-desktop-portal-gtk"
          # Bitwarden popup
          "float, class:chrome-nngceckbapebfimnlniiiahkandclblb-Default"
          "immediate, class:^(cs2)$"
          # Ignore maximize requests from apps.
          "suppressevent maximize, class:.*"
          # Fix some dragging issues with XWayland
          "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        ];
      };

      inherit (cfg) extraConfig;
    };

    services.swww.enable = true;
    services.hyprpolkitagent.enable = true;

    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };
        listener = [
          {
            timeout = 180;
            on-timeout = "systemctl suspend";
          }
          {
            timeout = 90;
            on-timeout = "brightnessctl -s s 5%"; # dim screen
            on-resume = "brightnessctl -r";
          }
        ];
      };
    };

    programs.hyprlock.enable = true;
  };
}
