{
  imports = [
    ./apps/thunar.nix
    ./apps/steam.nix
    ./services/tlp.nix
    ./boot.nix
  ];

  programs.firefox.enable = true;
}
