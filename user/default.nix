{
  hm = {
    imports = [
      ./shell
    ];
  };

  zsh = ./shell/zsh.nix;
  qtile = ./qtile/qtile.nix;
  lazygit = ./lazygit/lazygit.nix;
  rofi = ./rofi/rofi.nix;

  packages = {
    spotify-spotx = ./spotify/spotify-spotx.nix;
  };
}
