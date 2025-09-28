{pkgs, ...}: {
  fonts.packages = with pkgs; [
    liberation_ttf
    nerd-fonts.jetbrains-mono
  ];
  fonts.fontconfig.subpixel.rgba = "rgb";

  environment.variables = {
    # Stem darkening
    FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
  };
}
