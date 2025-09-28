{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../system
  ];

  modules = {
    grub.enable = true;
    sddm.enable = true;
    steam.enable = true;
    wms.hyprland.enable = true;
    tlp.enable = true;
    nvidia = {
      enable = true;
      withSpecialization = true;
    };
  };

  boot.kernelParams = ["mem_sleep_default=s2idle"];

  networking.hostName = "aje";

  hardware.graphics = {
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };

  system.nixos.tags = ["${config.networking.hostName}"];
}
