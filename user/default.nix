{
  hm = {
    imports = [
      ./shell
      ./wms/hyprland
      ./wms/qtile
    ];

    modules.qtile.enable = true;
  };

  zsh = ./shell/zsh.nix;
  lazygit = ./lazygit/lazygit.nix;
  rofi = ./rofi/rofi.nix;
}
