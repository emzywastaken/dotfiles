{pkgs, ...}: {
  virtualisation = {
    libvirtd.enable = true;
    waydroid.enable = true;
    docker.enable = true;
  };

  programs.virt-manager.enable = true;

  environment.systemPackages = [pkgs.distrobox pkgs.winboat];
  users.users.emzy.extraGroups = ["docker"];
}
