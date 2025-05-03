{  pkgs, ... }:

{
  home.file.".zshrc".source = ./.zshrc;
  home.packages =  [
    pkgs.starship
  ];
}
