{pkgs, ...}: {
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  # Thumbnail support for images
  services.tumbler.enable = true;
  # Trash support
  services.gvfs.enable = true;
}
