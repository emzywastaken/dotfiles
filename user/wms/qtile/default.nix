{
  config,
  lib,
  ...
}: let
  cfg = config.modules.qtile;
in {
  options = {
    modules.qtile.enable = lib.mkEnableOption "qtile";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."qtile/config.py".source = ./config.py;
  };
}
