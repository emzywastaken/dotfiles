{lib, ...}: {
  imports = [
    ../home.nix # Shared config
  ];

  modules = {
    hyprland = {
      enable = true;
      monitorScale = 1.6;
      startupCommands = prev: lib.remove "waybar" prev ++ ["brightnessctl s 20%"];
    };
  };
}
