{pkgs, ...}: let
  themesDir = "rofi/themes";
in {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "${pkgs.kitty}/bin/kitty";
    theme = ./themes/gruvbox-material.rasi;
  };
  xdg.dataFile."${themesDir}/squared-everforest.rasi".source = ./themes/squared-everforest.rasi;
  xdg.dataFile."${themesDir}/tokyonight.rasi".source = ./themes/tokyonight.rasi;
}
