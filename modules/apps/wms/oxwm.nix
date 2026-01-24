{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.oxwm;
in {
  options = {
    modules.oxwm.enable = lib.mkEnableOption "oxwm" // {default = true;};
  };

  config = lib.mkIf cfg.enable {
    services.xserver = {
      enable = true;
      excludePackages = [pkgs.xterm];
      windowManager.oxwm.enable = true;
      autoRepeatDelay = 400;
      autoRepeatInterval = 30;
    };

    services.libinput.touchpad.naturalScrolling = true;

    environment.systemPackages = [
      pkgs.xclip
      pkgs.xwallpaper
    ];
  };
}
