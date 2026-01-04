{
  config,
  lib,
  ...
}: let
  cfg = config.modules.niri;
in {
  options = {
    modules.niri.enable = lib.mkEnableOption "niri";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."niri/config.kdl".source = ./config.kdl;
  };
}
