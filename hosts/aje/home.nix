{pkgs, ...}: {
  imports = [
    ../home.nix
  ];

  modules.hyprland = {
    enable = true;
  };

  home.packages = [
    pkgs.blender
  ];
}
