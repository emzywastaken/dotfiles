{
  pkgs,
  spotify,
  fetchurl
}:

let
  spotx = fetchurl {
    url = "https://raw.githubusercontent.com/SpotX-Official/SpotX-Bash/b1de24ec4c23c45da373dcb64a44e372253a0c16/spotx.sh";
    hash = "sha256-/p6cJKzaZzjcLJISFudstQjs+lPXnXx4f0vxKbF9Sqw=";
  };
in
spotify.overrideAttrs(oldAttrs: {
  nativeBuildInputs = oldAttrs.nativeBuildInputs ++ (with pkgs; [
    util-linux
    perl
    unzip
    zip
    curl
  ]);

  unpackPhase =
    "patchShebangs --build ${spotx}"
    + oldAttrs.unpackPhase;

  postInstall = ''bash ${spotx} -f -P "$out/share/spotify"'';
})
