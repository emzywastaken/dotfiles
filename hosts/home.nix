{
  pkgs,
  lib,
  ...
}: {
  home.username = "emzy";
  home.homeDirectory = "/home/emzy";

  home.stateVersion = "24.11";

  home.shell.enableShellIntegration = false;

  programs.kitty = {
    enable = true;
    font.name = "JetBrainsMono Nerd Font";
    font.size = 11;
    settings = {
      background_opacity = lib.mkDefault 0.8;
      confirm_os_window_close = 0;
      scrollback_pager_history_size = 5;
    };
    keybindings = {
      "ctrl+f2" = "detach_tab";
      "ctrl+f3" = "detach_tab ask";
    };
  };

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
