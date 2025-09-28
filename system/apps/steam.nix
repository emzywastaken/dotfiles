{
  lib,
  config,
  ...
}: let
  cfg = config.modules.steam;
in {
  options.modules = {
    steam.enable = lib.mkEnableOption "Enable steam with gamescope and gamemode optimization";
  };
  config = lib.mkIf cfg.enable {
    programs = {
      steam.enable = true;
      gamemode.enable = true;
      gamescope.enable = true;
    };
  };
}
