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
      displayManager.sessionCommands = ''
        xrandr --dpi 127.3
        xwallpaper --zoom ~/walls/birds.png
      '';
    };

    services.libinput.touchpad.naturalScrolling = true;

    environment.systemPackages = [
      pkgs.xclip
      pkgs.xwallpaper
    ];

    hm.xdg.configFile."qtile/config.py".source = ./config.py;
  };
}
