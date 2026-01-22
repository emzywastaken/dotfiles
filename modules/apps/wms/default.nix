{
  imports = [
    ./hyprland
    ./qtile
    ./niri
  ];

  hm = {
    services.blueman-applet.enable = true;
    services.network-manager-applet.enable = true;
  };
}
