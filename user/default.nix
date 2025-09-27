{
  hm = {
    imports = [
      ./shell
      ./wms/hyprland
    ];
  };

  zsh = ./shell/zsh.nix;
  lazygit = ./lazygit/lazygit.nix;
  rofi = ./rofi/rofi.nix;

  wms = {
    qtile = ./wms/qtile/qtile.nix;
    hyprland = ./wms/hyprland;
  };
}
