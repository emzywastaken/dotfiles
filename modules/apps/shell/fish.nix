{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.fish;
in {
  options.modules = {
    fish.enable = lib.mkEnableOption "custom fish module";
    fish.withStarshipPrompt = lib.mkEnableOption "starship prompt";
    fish.defaultInteractiveShell = lib.mkEnableOption "fish as the default interactive shell";
  };

  config = lib.mkIf cfg.enable {
    hm = {
      programs.fish.enable = true;

      programs.fish.interactiveShellInit = builtins.concatStringsSep "\n" [
        "test -r '/home/emzy/.opam/opam-init/init.fish' && source '/home/emzy/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true"
        (lib.optionalString cfg.withStarshipPrompt
          "${pkgs.starship}/bin/starship init fish | source")
      ];

      programs.fish.shellAbbrs = {
        lvim = "NVIM_APPNAME=lvim nvim";
        zed = "zeditor";
      };

      programs.fish.shellAliases = let
        icon = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/Michael-C-Buckley/nixos/1b09e5ae6c6431be61be8403c5774a47dbb2bbea/flake/user/files/.media/nixos.png";
          hash = "sha256-3D2YB12FozwBT0ltTzrq/e04zoF2gB4TDUTkYh/mfXQ=";
        };
      in {
        fetch = "fastfetch --logo ${icon} --logo-height 20 --logo-width 40";
      };

      programs.fzf.enable = true;
      programs.fzf.enableFishIntegration = true;

      # make fish default interactive shell
      home.sessionVariables = lib.mkIf cfg.defaultInteractiveShell {
        SHELL = "${lib.getExe pkgs.fish}";
      };

      programs.kitty = lib.mkIf cfg.defaultInteractiveShell {
        settings.shell = "${lib.getExe pkgs.fish}";
      };

      home.packages =
        [pkgs.fastfetch]
        ++ lib.optional cfg.withStarshipPrompt
        pkgs.starship;
    };
  };
}
