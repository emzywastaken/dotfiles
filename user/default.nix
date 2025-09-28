{
  hm = {
    imports = [
      ./shell
      ./lazygit
      ./wms/hyprland
      ./wms/qtile
    ];

    modules = {
      qtile.enable = true;
      lazygit.enable = true;
    };
  };

  rofi = ./rofi/rofi.nix;
}
