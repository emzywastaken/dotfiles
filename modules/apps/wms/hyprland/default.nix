{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types concatStringsSep getExe;
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
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

    modules = {
      waybar.enable = lib.mkDefault true;
      noctalia-shell.enable = true;
    };

    hj.xdg.config.files."hypr/hyprland.conf".text = let
      toggle-fullcharge = pkgs.writeShellScriptBin "toggle-fullcharge" ''
        export SHELL=/bin/sh
        pkexec $SHELL <<'EOF'
        current_end=$(tlp-stat -b | awk '/charge_control/ {print $3}')
        if [ "$current_end" = "100" ]; then
          tlp setcharge
        else
          tlp fullcharge
        fi
        EOF
      '';

      default-execs = [
        "waybar"
        # TODO: use new custom options
        "hyprctl setcursor Bibata-Modern-Ice 24"
        # "hyprctl setcursor ${config.home.pointerCursor.name} ${toString config.home.pointerCursor.size}"
      ];
      applied-execs =
        if lib.isFunction cfg.startupCommands
        then cfg.startupCommands default-execs
        else default-execs ++ cfg.startupCommands;
    in ''
      source = ${./binds.conf}

      $toggleFullcharge = ${getExe toggle-fullcharge}

      ${concatStringsSep "\n" (map (cmd: "exec-once = ${cmd}") applied-execs)}

      monitor=,preferred,auto,${toString cfg.monitorScale}

      general {
        gaps_in=5
        gaps_out=20
        border_size=2
        col.active_border=rgb(89b4fa)
        col.inactive_border=rgba(595959aa)
        resize_on_border=true
        layout=dwindle
        allow_tearing=true
      }

      decoration {
        rounding=10
        rounding_power=2
        active_opacity=1.0
        inactive_opacity=1.0

        shadow {
          enabled=true
          range=4
          render_power=3
          color=rgba(1a1a1aee)
        }
        blur {

          enabled=true
          size=3
          passes=1
          vibrancy=0.1696
        }
      }

      animations {
        enabled=yes
        bezier=easeOutQuint, 0.23, 1, 0.32, 1
        bezier=easeInOutCubic, 0.65, 0.05, 0.36, 1
        bezier=linear, 0, 0, 1, 1
        bezier=almostLinear, 0.5, 0.5, 0.75, 1.0
        bezier=quick, 0.15, 0, 0.1, 1
        animation=global, 1, 10, default
        animation=border, 1, 5.39, easeOutQuint
        animation=windows, 1, 4.79, easeOutQuint
        animation=windowsIn, 1, 4.1, easeOutQuint, popin 87%
        animation=windowsOut, 1, 1.49, linear, popin 87%
        animation=fadeIn, 1, 1.73, almostLinear
        animation=fadeOut, 1, 1.46, almostLinear
        animation=fade, 1, 3.03, quick
        animation=layers, 1, 3.81, easeOutQuint
        animation=layersIn, 1, 4, easeOutQuint, fade
        animation=layersOut, 1, 1.5, linear, fade
        animation=fadeLayersIn, 1, 1.79, almostLinear
        animation=fadeLayersOut, 1, 1.39, almostLinear
        animation=workspaces, 1, 1.94, almostLinear, fade
        animation=workspacesIn, 1, 1.21, almostLinear, fade
        animation=workspacesOut, 1, 1.94, almostLinear, fade
      }

      input {
        kb_layout=us
        follow_mouse=1
        accel_profile=flat
        sensitivity=0

        touchpad {
          disable_while_typing=true
          natural_scroll=true
          scroll_factor=0.300000
        }
      }

      gestures {
        # https://wiki.hyprland.org/Configuring/Variables/#gestures
        gesture=3, horizontal, workspace
      }

      binds {
        workspace_back_and_forth=true
      }

      device {
        name=ascp1201:00-093a:3017-touchpad
        sensitivity=0.300000
      }

      misc {
        disable_hyprland_logo=true
        force_default_wallpaper=-1
      }

      render {
        cm_enabled=false
      }

      xwayland {
        force_zero_scaling=true
      }

      windowrule=float on, match:class xdg-desktop-portal-gtk
      windowrule=float on, match:class chrome-nngceckbapebfimnlniiiahkandclblb-Default
      windowrule=immediate on, match:class ^(cs2)$
      windowrule=suppress_event maximize, match:class .*
      windowrule=no_focus on, match:class ^$, match:title ^$, match:xwayland 1, match:float 1, match:fullscreen 0, match:pin 0

      ${cfg.extraConfig}
    '';

    services.hypridle.enable = true;
    hj.xdg.config.files."hypr/hypridle.conf".text = ''
      listener {
        timeout=180
        on-timeout=systemctl suspend
      }

      listener {
        timeout=90
        on-timeout=brightnessctl -s s 5% # dim screen
        on-resume=brightnessctl -r
      }

    '';

    hm = {config, ...}: {
      services.swww.enable = true;
      services.hyprpolkitagent.enable = true;
    };
  };
}
