{
  imports = [
    ./hyprland
    ./qtile
    ./niri
    ./oxwm.nix
  ];

  hm = {
    services.blueman-applet.enable = true;
    services.network-manager-applet.enable = true;
  };
}
