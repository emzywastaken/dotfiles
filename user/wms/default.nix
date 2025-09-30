{
  imports = [
    ./hyprland
    ./qtile
  ];

  services.dunst = {
    enable = true;
    settings = {
      global = {
        corner_radius = 10;
      };
    };
  };
  services.blueman-applet.enable = true;
  services.network-manager-applet.enable = true;
}
