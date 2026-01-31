{
  pkgs,
  lib,
  ...
}: {
  hj = {
    packages = [pkgs.btop];
    xdg.config.files."btop/btop.conf" = {
      generator = lib.generators.toKeyValue {};
      value.vim_keys = true;
    };
  };
}
