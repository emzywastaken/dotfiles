{
  pkgs,
  inputs,
  ...
}: {
  # Shared packages
  programs = {
    firefox.enable = true;
    # firejail.enable = true;
    zsh.enable = true;
    fish.enable = true;
    nix-ld.enable = true;
    localsend.enable = true;
  };

  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

    alacritty
    brightnessctl
    btop
    fd
    fzf
    git
    go
    nodejs_22
    pavucontrol
    psmisc # killall
    python3
    ripgrep
    rustup
    unzip
    vim
    wget
    wl-clipboard

    # cc
    gcc
    gnumake
    cmake
    man-pages
  ];
}
