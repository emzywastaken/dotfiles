{
  pkgs,
  lib,
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
    wms = {
      hyprland.enable = true;
      niri.enable = true;
    };
    tlp = {
      enable = true;
      chargeThreshold = 80;
    };
  };

  services.vnstat.enable = true;

  networking.hostName = "ink";

  hardware.graphics = {
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      vpl-gpu-rt # Quicksync
    ];
  };

  powerManagement.powertop.enable = true;

  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};

  security.wrappers.btop = {
    owner = "root";
    group = "root";
    source = lib.getExe pkgs.btop;
    capabilities = "cap_perfmon,cap_dac_read_search+ep";
  };

  virtualisation.waydroid.enable = true;

  system.nixos.tags = ["${config.networking.hostName}"];
}
