{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.fish;
in {
  options.modules = {
    fish.enable = lib.mkEnableOption "Whether to enable custom fish module";
    fish.withStarshipPrompt = lib.mkEnableOption "Configure prompt with starship";
    fish.defaultInteractiveShell = lib.mkEnableOption "Whether to make fish the default interactive shell";
  };

  config = lib.mkIf cfg.enable {
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

    programs.fzf.enable = true;
    programs.fzf.enableFishIntegration = true;

    # make fish default interactive shell
    home.sessionVariables = lib.mkIf cfg.defaultInteractiveShell {
      SHELL = "fish";
    };

    programs.kitty = lib.mkIf cfg.defaultInteractiveShell {
      settings.shell = "${lib.getExe pkgs.fish}";
    };

    home.packages = lib.mkIf cfg.withStarshipPrompt [
      pkgs.starship
    ];
  };
}
