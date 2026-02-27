{
  hj.xdg.config.files."fastfetch/config.jsonc".text = builtins.toJSON {
    display.separator = " 󰑃  ";
    logo.padding.top = 1;
    modules = [
      "break"
      {
        key = " DISTRO";
        keyColor = "yellow";
        type = "os";
      }
      {
        key = "│ ├";
        keyColor = "yellow";
        type = "kernel";
      }
      {
        key = "│ ├󰏖";
        keyColor = "yellow";
        type = "packages";
      }
      {
        key = "│ ├";
        keyColor = "yellow";
        text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
        type = "command";
      }
      {
        key = "│ └";
        keyColor = "yellow";
        type = "shell";
      }
      {
        key = " DE/WM";
        keyColor = "blue";
        type = "wm";
      }
      {
        key = "│ ├󰉼";
        keyColor = "blue";
        type = "wmtheme";
      }
      {
        key = "│ ├󰀻";
        keyColor = "blue";
        type = "icons";
      }
      {
        key = "│ ├";
        keyColor = "blue";
        type = "cursor";
      }
      {
        key = "│ ├";
        keyColor = "blue";
        type = "terminalfont";
      }
      {
        key = "│ └";
        keyColor = "blue";
        type = "terminal";
      }
      {
        key = "󰌢 SYSTEM";
        keyColor = "green";
        type = "host";
      }
      {
        key = "│ ├󰻠";
        keyColor = "green";
        type = "cpu";
      }
      {
        format = "{2}";
        key = "│ ├󰻑";
        keyColor = "green";
        type = "gpu";
      }
      {
        compactType = "original-with-refresh-rate";
        key = "│ ├󰍹";
        keyColor = "green";
        type = "display";
      }
      {
        key = "│ ├󰾆";
        keyColor = "green";
        type = "memory";
      }
      {
        key = "│ ├󰓡";
        keyColor = "green";
        type = "swap";
      }
      {
        key = "│ ├󰅐";
        keyColor = "green";
        type = "uptime";
      }
      {
        format = "{2}";
        key = " AUDIO";
        keyColor = "magenta";
        type = "sound";
      }
      {
        key = "│ ├󰥠";
        keyColor = "magenta";
        type = "player";
      }
      {
        key = "│ └󰝚";
        keyColor = "magenta";
        type = "media";
      }
      {
        format = "                                         ";
        type = "custom";
      }
      "break"
    ];
  };
}
