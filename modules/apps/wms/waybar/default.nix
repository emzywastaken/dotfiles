{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf types;
  cfg = config.modules.waybar;
in {
  options.modules = {
    waybar = {
      enable = mkEnableOption "whether to enable waybar";
      preset = mkOption {
        type = types.enum ["gruvbox" "broken-purple"];
        default = "broken-purple";
        description = "configuration preset to use";
      };
    };
  };

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      style = ./configs/${cfg.preset}/style.css;
    };
    xdg.configFile."waybar/config.jsonc".source = ./configs/${cfg.preset}/config.jsonc;
  };
}
