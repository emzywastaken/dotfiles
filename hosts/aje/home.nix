{pkgs, ...}: {
  imports = [
    ../home.nix # Shared config
  ];

  modules.hyprland = {
    enable = true;
  };

  home.packages = [
    pkgs.blender
  ];

  wayland.windowManager.hyprland = {
    settings.exec-once = ["brightnessctl s 20%"];
  };
}
