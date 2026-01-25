{
  pkgs,
  inputs,
  ...
}: {
  modules = {
    lazygit.enable = true;
    fish = {
      enable = true;
      defaultInteractiveShell = true;
    };
  };

  # Shared packages
  programs = {
    firefox.enable = true;
    zsh.enable = true;
    nix-ld.enable = true;
    localsend.enable = true;
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
    btop
    fd
    fzf
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
