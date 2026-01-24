{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.modules.noctalia-shell;
in {
  options = {
    modules.noctalia-shell.enable = lib.mkEnableOption "noctalia-shell";
  };

  config = lib.mkIf cfg.enable {
    services.upower.enable = true;
    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      pkgs.gpu-screen-recorder
    ];
  };
}
