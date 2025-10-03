{lib, ...}: {
  imports = [
    ../home.nix # Shared config
  ];

  modules = {
    hyprland = {
      enable = true;
      monitorScale = 1.67;
      startupCommands = prev: lib.remove "waybar" prev ++ ["brightnessctl s 20%"];
    };
  };

  wayland.windowManager.hyprland.settings = {
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
