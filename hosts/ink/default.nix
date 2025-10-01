{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  modules = {
    grub.enable = true;
    sddm.enable = true;
    steam.enable = true;
    wms.hyprland.enable = true;
    # TODO: compare with asusctl profiles
    tlp = {
      enable = true;
      chargeThreshold = 80;
    };
  };

  networking.hostName = "ink";

  hardware.graphics = {
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      vpl-gpu-rt # Quicksync
    ];
  };

  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};

  system.nixos.tags = ["${config.networking.hostName}"];
}
