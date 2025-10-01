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
    wms.hyprland.enable = true;
    # TODO: compare with asusctl profiles
    # tlp = {
    #   enable = true;
    #   chargeThreshold = 80;
    # };
  };

  networking.hostName = "ink";

  hardware.graphics = {
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      vpl-gpu-rt # Quicksync
    ];
  };

  powerManagement.powertop.enable = true;
  services.power-profiles-daemon.enable = true;

  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};

  security.wrappers.btop = {
    owner = "root";
    group = "root";
    source = lib.getExe pkgs.btop;
    capabilities = "cap_perfmon,cap_dac_read_search+ep";
  };

  system.nixos.tags = ["${config.networking.hostName}"];
}
