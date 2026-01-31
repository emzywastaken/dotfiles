{pkgs, ...}: let
  themesDir = "rofi/themes";
in {
  hj = {
    packages = [pkgs.rofi];

    xdg.config.files."rofi/config.rasi".text = ''
      configuration {
        location: 0;
        xoffset: 0;
        yoffset: 0;
        terminal: "xdg-terminal-exec";
      }
      @theme "tokyonight-custom"
    '';

    xdg.data.files."${themesDir}/squared-everforest.rasi".source = ./themes/squared-everforest.rasi;
    xdg.data.files."${themesDir}/tokyonight-custom.rasi".source = ./themes/tokyonight-custom.rasi;
    xdg.data.files."${themesDir}/tokyonight.rasi".source = ./themes/tokyonight.rasi;
  };
}
