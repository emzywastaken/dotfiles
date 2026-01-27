{pkgs, ...}: {
  hj = {
    packages = [pkgs.alacritty];

    xdg.config.files."alacritty/alacritty.toml" = {
      generator = (pkgs.formats.toml {}).generate "alacritty.toml";
      value = {
        window.opacity = 0.9;
        font.size = 11;
        font.normal = {
          family = "JetBrainsMonoNerdFont";
          style = "Regular";
        };
      };
    };
  };
}
