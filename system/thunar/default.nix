{...}: {
  programs.thunar.enable = true;

  # Thumbnail support for images
  services.tumbler.enable = true;
  # Trash support
  services.gvfs.enable = true;
}
