{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules;
in {
  options.modules = {
    fish.enable = lib.mkEnableOption "Whether to enable custom fish module";
    fish.defaultInteractiveShell = lib.mkEnableOption "Whether to make fish the default interactive shell";
  };

  config = lib.mkIf cfg.fish.enable {
    programs.fish.enable = true;
    # make fish default interactive shell
    programs.kitty = lib.mkIf cfg.fish.defaultInteractiveShell {
      settings.shell = "${lib.getExe pkgs.fish}";
    };
  };
}
