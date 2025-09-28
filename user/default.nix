{
  hm = {
    imports = [
      ./shell
      ./wms/hyprland
      ./wms/qtile
    ];

    modules.qtile.enable = true;
  };

  lazygit = ./lazygit/lazygit.nix;
  rofi = ./rofi/rofi.nix;
}
