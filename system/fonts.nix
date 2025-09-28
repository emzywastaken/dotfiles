{pkgs, ...}: {
  fonts.packages = with pkgs; [
    liberation_ttf
    nerd-fonts.jetbrains-mono
  ];
  fonts.fontconfig.subpixel.rgba = "rgb";
}
