{
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

  hardware.graphics = {
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      vpl-gpu-rt # Quicksync
    ];
  };

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

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  system.nixos.tags = ["${config.networking.hostName}"];
}
