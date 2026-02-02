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
    hyprland = {
      enable = true;
      monitorScale = 1.6;
      startupCommands = prev:
        lib.remove "waybar" prev
        ++ [
          "brightnessctl s 20%"
          "noctalia-shell"
        ];
      extraConfig = ''
        device {
          name=ascp1201:00-093a:3017-touchpad
          sensitivity=0.3
        }
        xwayland {
          force_zero_scaling=true
        }
      '';
    };
    niri.enable = true;
    waybar.preset = "broken-purple";
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
