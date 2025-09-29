{pkgs, ...}: {
  imports = [
    ../home.nix # Shared config
  ];

  modules.hyprland = {
    enable = true;
    startupCommands = ["brightnessctl s 20%"];
  };

  home.packages = [
    pkgs.blender
  ];
}
