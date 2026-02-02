{
  pkgs,
  lib,
  ...
}: {
  home.username = "emzy";
  home.homeDirectory = "/home/emzy";

  home.stateVersion = "24.11";

  home.shell.enableShellIntegration = false;

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
