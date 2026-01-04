{
  fetchFromGitHub,
  python3Packages,
  lib,
}: let
  rev = "2103ec06137557352cc235ae8d366bd69dd246ca";
  inherit (lib.sources) shortRev;
in
  python3Packages.buildPythonApplication {
    pname = "wayland-debug";
    version = "${shortRev rev}-2025-08-09";
    pyproject = false;

    src = fetchFromGitHub {
      inherit rev;
      owner = "wmww";
      repo = "wayland-debug";
      hash = "sha256-RHFxBgsuM8qVTM6P16MpB0xpA8sW6/yFmzYX2gwcoSM=";
    };

    postPatch = ''
      patchShebangs ./resources/*.sh
    '';

    installPhase = ''
      mkdir -p $out/lib/dist
      cp -r * $out/lib/dist

      mkdir -p $out/bin
      ln -s $out/lib/dist/main.py $out/bin/wayland-debug
    '';

    meta.mainProgram = "wayland-debug";
  }
