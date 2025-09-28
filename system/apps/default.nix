{pkgs, ...}: {
  # Shared packages
  programs = {
    firefox.enable = true;
    # firejail.enable = true;
    zsh.enable = true;
    fish.enable = true;
    nix-ld.enable = true;
    localsend.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
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
    xclip # moave to x11 related module
    xwallpaper

    # cc
    gcc
    gnumake
    cmake
    man-pages
  ];
}
