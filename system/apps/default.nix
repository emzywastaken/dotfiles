{pkgs, ...}: {
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
    alacritty
    btop
    brightnessctl
    fd
    fzf
    git
    go
    networkmanagerapplet
    nodejs_22
    pavucontrol
    psmisc # killall
    python3
    ripgrep
    rustup
    swww
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
