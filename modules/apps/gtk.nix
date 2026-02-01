{
  pkgs,
  lib,
  ...
}: let
  settings = {
    Settings = {
      gtk-cursor-theme-name = "Bibata-Modern-Ice";
      gtk-cursor-theme-size = 24;
      gtk-icon-theme-name = "Gruvbox-Plus-Dark";
      gtk-theme-name = "adw-gtk3-dark";
    };
  };
  settingsIni = lib.generators.toINI {} settings;
in {
  # TODO: Abstract with options
  programs.dconf.profiles.user.databases = [
    {
      settings = {
        "org/gnome/desktop/interface" = {
          font-name = "DejaVu Sans";
          gtk-theme = "adw-gtk3-dark";
          icon-theme = "Gruvbox-Plus-Dark";
          cursor-theme = "Bibata-Modern-Ice";
          color-scheme = "prefer-dark";
        };
      };
    }
  ];

  hj.xdg.config.files."gtk-3.0/settings.ini".text = settingsIni;
  hj.xdg.config.files."gtk-4.0/settings.ini".text = settingsIni;

  environment = {
    systemPackages = [
      pkgs.adw-gtk3
      pkgs.gruvbox-plus-icons
      pkgs.bibata-cursors
    ];

    sessionVariables = {
      XCURSOR_SIZE = 24;
      XCURSOR_THEME = "Bibata-Modern-Ice";
    };
  };
}
