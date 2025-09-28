{
  imports = [
    ./apps/thunar.nix
    ./apps/steam.nix
    ./boot.nix
  ];

  programs.firefox.enable = true;
}
