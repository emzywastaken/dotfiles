{pkgs, ...}: {
  imports = [
    ../home.nix
  ];

  modules.hyprland = {
    enable = true;
    monitorScale = 1.6;
  };

  home.packages = [
    pkgs.blender
  ];
}
