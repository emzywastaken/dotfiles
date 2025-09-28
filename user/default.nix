{
  imports = [
    ./shell
    ./lazygit
    ./wms/hyprland
    ./wms/qtile
    ./rofi/rofi.nix
  ];

  modules = {
    qtile.enable = true;
    lazygit.enable = true;
  };
}
