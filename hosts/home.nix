{
  pkgs,
  lib,
  ...
}: {
  home.username = "emzy";
  home.homeDirectory = "/home/emzy";

  home.stateVersion = "24.11";

  home.shell.enableShellIntegration = false;

  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    size = 24;
    name = "Bibata-Modern-Ice";
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  services.syncthing.enable = true;
}
