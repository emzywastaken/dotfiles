{
  lib,
  config,
  ...
}: let
  cfg = config.modules.steam;
in {
  options.modules = {
    steam.enable = lib.mkEnableOption "steam with gamescope and gamemode optimizations";
  };
  config = lib.mkIf cfg.enable {
    programs = {
      steam.enable = true;
      gamemode.enable = true;
      gamescope.enable = true;
    };
  };
}
