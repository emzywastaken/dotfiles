{lib, ...}: {
  imports = [
    ../home.nix # Shared config
  ];

  services.dunst.enable = lib.mkForce false;

  wayland.windowManager.hyprland.settings = {
    general."col.active_border" = lib.mkForce "rgb(89b4fa)";
    xwayland.force_zero_scaling = true;
    device = {
      name = "ascp1201:00-093a:3017-touchpad";
      sensitivity = 0.3;
    };
  };

  programs.kitty = {
    themeFile = "tokyo_night_night";
    settings.background_opacity = 1.0;
  };
}
