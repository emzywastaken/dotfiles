{pkgs, ...}: {
  fonts.packages = with pkgs; [
    liberation_ttf
    nerd-fonts.jetbrains-mono
    nerd-fonts.monaspace
  ];
  fonts.fontconfig.subpixel.rgba = "rgb";

  environment.variables = {
    # Stem darkening
    FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
  };
}
