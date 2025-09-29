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
    tlp.enable = true;
    nvidia = {
      enable = true;
      withSpecialisation = true;
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
  nixpkgs.config.cudaSupport = true;
}
