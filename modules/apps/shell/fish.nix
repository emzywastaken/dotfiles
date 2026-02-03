{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.fish;
  icon = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/Michael-C-Buckley/nixos/1b09e5ae6c6431be61be8403c5774a47dbb2bbea/flake/user/files/.media/nixos.png";
    hash = "sha256-3D2YB12FozwBT0ltTzrq/e04zoF2gB4TDUTkYh/mfXQ=";
  };
in {
  options.modules = {
    fish.enable = lib.mkEnableOption "custom fish module";
    fish.withStarshipPrompt = lib.mkEnableOption "starship prompt";
    fish.defaultInteractiveShell = lib.mkEnableOption "fish as the default interactive shell";
  };

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;
      interactiveShellInit = builtins.concatStringsSep "\n" [
        "test -r '/home/emzy/.opam/opam-init/init.fish' && source '/home/emzy/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true"
        "${lib.getExe pkgs.fzf} --fish | source"
        (lib.optionalString cfg.withStarshipPrompt
          "${pkgs.starship}/bin/starship init fish | source")
      ];
      shellAbbrs = {
        lvim = "NVIM_APPNAME=lvim nvim";
        zed = "zeditor";
      };
      shellAliases.fetch = "fastfetch --logo ${icon} --logo-height 20 --logo-width 40";
    };

    environment = {
      variables = lib.mkIf cfg.defaultInteractiveShell {
        SHELL = "${lib.getExe pkgs.fish}";
      };

      systemPackages =
        [
          pkgs.fzf
          pkgs.fastfetch
        ]
        ++ lib.optional cfg.withStarshipPrompt pkgs.starship;
    };

    hj.xdg.config.files."kitty/kitty.conf".text = lib.mkIf cfg.defaultInteractiveShell "shell ${lib.getExe pkgs.fish}";
  };
}
