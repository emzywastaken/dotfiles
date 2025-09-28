{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../system
  ];

  modules = {
    grub.enable = true;
    steam.enable = true;
    sddm.enable = true;
    tlp = {
      enable = true;
      chargeThreshold = 80;
    };
  };

  networking.hostName = "ink";
  networking.networkmanager.enable = true;

  time.timeZone = "Africa/Lagos";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver = {
    enable = true;
    excludePackages = [pkgs.xterm];
    windowManager.qtile.enable = true;
    autoRepeatDelay = 400;
    autoRepeatInterval = 30;
    displayManager.sessionCommands = ''
      xrandr --dpi 127.3
      xwallpaper --zoom ~/walls/birds.png
    '';
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
        vpl-gpu-rt # Quicksync
      ];
    };
  };

  # yes yes, download more ram
  zramSwap.enable = true;

  services.openssh.enable = true;

  services.printing.enable = true;
  services.printing.drivers = with pkgs; [hplip];

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  hardware.openrazer.enable = true;
  hardware.openrazer.users = ["emzy"];

  services.libinput.touchpad.naturalScrolling = true;

  # needed for store VS Code auth token
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  users.users.emzy = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    users = {
      "emzy" = import ./home.nix;
    };
  };

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    variables = {
      FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
    };
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

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
    xclip
    xwallpaper

    # cc
    gcc
    gnumake
    cmake
    man-pages
  ];

  fonts.packages = with pkgs; [
    liberation_ttf
    nerd-fonts.jetbrains-mono
  ];
  fonts.fontconfig.subpixel.rgba = "rgb";

  nixpkgs.config.allowUnfree = true;
  nix = {
    settings = {
      extra-substituters = [
        "https://nix-community.cachix.org"
      ];

      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      experimental-features = ["nix-command" "flakes"];
    };
    # nixd aksed for this
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    package = pkgs.nixVersions.latest;
  };

  system.nixos.tags = ["${config.networking.hostName}"];
  system.stateVersion = "24.11";
}
