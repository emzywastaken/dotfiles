{
  pkgs,
  lib,
  config,
  ...
}: {
  # TODO: Abstract into module with options
  hj = {
    packages = [pkgs.kitty];

    xdg.config.files."kitty/kitty.conf".text = ''
      font_family JetBrainsMono Nerd Font
      font_size 11

      include ${pkgs.kitty-themes}/share/kitty-themes/tokyo_night_night.conf

      # Shell integration is sourced and configured manually
      shell_integration no-rc

      background_opacity 1.000000
      confirm_os_window_close 0
      scrollback_pager_history_size 5

      map ctrl+f2 detach_tab
      map ctrl+f3 detach_tab ask
    '';
  };
}
