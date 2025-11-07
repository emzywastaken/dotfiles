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
    programs.lazygit = {
      enable = true;
      settings = {
        git.pagers = [
          {
            colorArg = "always";
            pager = "${pkgs.delta}/bin/delta --dark --paging=never";
          }
        ];
      };
    };
  };
}
