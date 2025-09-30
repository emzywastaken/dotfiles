{
  imports = [
    ./wms
    ./shell
    ./lazygit
    ./rofi/rofi.nix
  ];

  modules = {
    qtile.enable = true;
    lazygit.enable = true;
  };
}
