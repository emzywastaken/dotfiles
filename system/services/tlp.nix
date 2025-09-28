{
  lib,
  config,
  ...
}: let
  cfg = config.modules.tlp;
in {
  options.modules.tlp = {
    enable = lib.mkEnableOption "Enable tlp";
    chargeThreshold = lib.mkOption {
      type = lib.types.ints.between 1 100;
      default = 100;
      description = "Battery charging stop threshold (1–100). Not all devices support this";
    };
  };
  config = {
    services.tlp = lib.mkIf cfg.enable {
      enable = true;
      settings = {
        # this needs to be set otherwise tlp would ignore stop thresh
        START_CHARGE_THRESH_BAT0 = 0;
        STOP_CHARGE_THRESH_BAT0 = cfg.chargeThreshold;
      };
    };
  };
}
