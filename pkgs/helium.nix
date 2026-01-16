{
  pkgs,
  appimageTools,
}: let
  version = "0.7.10.1";
in
  appimageTools.wrapType2 {
    pname = "helium";
    inherit version;

    src = pkgs.fetchurl {
      url = "https://github.com/imputnet/helium-linux/releases/download/${version}/helium-${version}-x86_64.AppImage";
      sha256 = "sha256-11xSlHIqmyyVwjjwt5FmLhp72P3m07PppOo7a9DbTcE=";
    };
  }
