_: {
  imports = [
    ../home.nix # Shared config
  ];

  modules = {
    hyprland = {
      enable = true;
      monitorScale = 1.6;
    };
  };

  wayland.windowManager.hyprland = {
    settings.exec-once = ["brightnessctl s 20%"];
  };
}
