{
  pkgs,
  lib,
  ...
}: let
  deltaCmd = lib.getExe pkgs.delta;
  deltaConfig = {
    core.pager = deltaCmd;
    interactive.diffFilter = "${deltaCmd} --color-only";
    delta = {
      navigate = true;
      dark = true;
      line-numbers = true;
    };
  };
in {
  programs.git.enable = true;
  environment.systemPackages = [pkgs.delta];

  hj.xdg.config.files."git/config" = {
    generator = lib.generators.toGitINI;
    value =
      {
        init.defaultBranch = "main";
        user.email = "amiamemetoo@gmail.com";
        user.name = "emzywastaken";
      }
      // deltaConfig;
  };
}
