{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.lazygit;
in {
  options = {
    modules.lazygit.enable = lib.mkEnableOption "lazygit";
  };

  config = lib.mkIf cfg.enable {
    hj = {
      packages = [
        pkgs.lazygit
      ];

      xdg.config.files."lazygit/config.yml" = {
        generator = lib.generators.toYAML {};
        value = {
          git.pagers = [
            {
              colorArgs = "always";
              pager = "${pkgs.delta}/bin/delta --dark --paging=never";
            }
          ];
        };
      };
    };
  };
}
