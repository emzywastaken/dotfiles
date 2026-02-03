{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.qtile;
in {
  options = {
    modules.qtile.enable = lib.mkEnableOption "qtile" // {default = true;};
  };

  config = lib.mkIf cfg.enable {
    services.xserver = {
      enable = true;
      excludePackages = [pkgs.xterm];
      windowManager.qtile.enable = true;
      autoRepeatDelay = 400;
      autoRepeatInterval = 30;
    };

    services.libinput.touchpad.naturalScrolling = true;

    environment.systemPackages = [
      pkgs.xclip
      pkgs.xwallpaper
    ];

    hj.xdg.config.files."qtile/config.py".source = ./config.py;
  };
}
