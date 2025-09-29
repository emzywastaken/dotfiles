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

  system.nixos.tags = ["${config.networking.hostName}"];
}
