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
    sddm.enable = true;
    grub.enable = true;
  };

  boot.kernelParams = ["mem_sleep_default=s2idle"];

  networking.hostName = "aje";
  networking.networkmanager.enable = true;

  time.timeZone = "Africa/Lagos";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver = {
    enable = true;
    excludePackages = [pkgs.xterm];
    videoDrivers = ["nvidia"];
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
        libvdpau-va-gl
      ];
    };
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = true;
      open = true;

      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  # yes yes, download more ram
  zramSwap.enable = true;

  specialisation = {
    gaming.configuration = {
      hardware.nvidia = {
        powerManagement.finegrained = lib.mkForce false;
        prime.sync.enable = lib.mkForce true;
        prime.offload = {
          enable = lib.mkForce false;
          enableOffloadCmd = lib.mkForce false;
        };
      };
    };
  };

  services.openssh.enable = true;

  services.tlp.enable = true;

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

  fonts.packages = with pkgs; [
    liberation_ttf
    nerd-fonts.jetbrains-mono
  ];
  fonts.fontconfig.subpixel.rgba = "rgb";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.cudaSupport = true;
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
