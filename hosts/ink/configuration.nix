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

  hardware.graphics = {
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      vpl-gpu-rt # Quicksync
    ];
  };

  system.nixos.tags = ["${config.networking.hostName}"];
}
