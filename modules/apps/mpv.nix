{
  pkgs,
  lib,
  ...
}: {
  hj = {
    packages = [pkgs.mpv];

    xdg.config.files."mpv/mpv.conf" = {
      generator = lib.generators.toKeyValue {};
      value = {
        hwdec = "auto";
        vo = "gpu";
        profile = "gpu-hq";
        gpu-context = "wayland";
      };
    };
  };
}
