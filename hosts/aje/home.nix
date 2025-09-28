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
}
