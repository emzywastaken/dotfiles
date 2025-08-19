{pkgs}: let
  image = pkgs.fetchurl {
    url = "https://gruvbox-wallpapers.pages.dev/wallpapers/anime/wall.jpg";
    sha256 = "sha256-Dt5A3cA5M+g82RiZn1cbD7CVzAz/b8c1nTEpkp273/s=";
  };
in
  pkgs.stdenvNoCC.mkDerivation {
    name = "sddm-theme";

    src = pkgs.fetchFromGitHub {
      owner = "MarianArlt";
      repo = "sddm-sugar-dark";
      rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
      sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
    };

    installPhase = ''
      mkdir -p $out
      cp -R ./* $out/
      cd $out/
      rm Background.jpg
      cp -r ${image} $out/Background.jpg
    '';
  }
