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

  gtk = {
    enable = true;
    theme.package = pkgs.adw-gtk3;
    theme.name = "adw-gtk3-dark";

    iconTheme.package = pkgs.gruvbox-plus-icons;
    iconTheme.name = "Gruvbox-Plus-Dark";
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
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
