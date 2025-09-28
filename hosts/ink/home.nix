{pkgs, ...}: {
  imports = [
    ../home.nix # Shared config
  ];

  modules = {
    hyprland = {
      enable = true;
      monitorScale = 1.6;
    };
  };
}
