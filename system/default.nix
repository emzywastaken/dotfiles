let
  # TODO: make recursive
  importDir = dir: map (file: "${toString dir}/${file}") (builtins.attrNames (builtins.readDir dir));
in {
  imports =
    [
      ./boot.nix
    ]
    ++ importDir ./services
    ++ importDir ./apps;
}
