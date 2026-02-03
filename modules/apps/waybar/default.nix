{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf types;
  cfg = config.modules.waybar;
in {
  options.modules = {
    waybar = {
      enable = mkEnableOption "waybar";
      preset = mkOption {
        type = types.enum ["gruvbox" "broken-purple"];
        default = "broken-purple";
        description = "configuration preset to use";
      };
    };
  };

  config = mkIf cfg.enable {
    hj = {
      packages = [pkgs.waybar];
      xdg.config.files."waybar/config.jsonc".source = ./configs/${cfg.preset}/config.jsonc;
      xdg.config.files."waybar/style.css".source = ./configs/${cfg.preset}/style.css;
    };
  };
}
