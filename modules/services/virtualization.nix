{pkgs, ...}: {
  virtualisation = {
    libvirtd.enable = true;
    waydroid.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };

  programs.virt-manager.enable = true;

  environment.systemPackages = [pkgs.distrobox];
}
