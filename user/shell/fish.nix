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

    programs.fish.interactiveShellInit =
      lib.mkIf cfg.withStarshipPrompt
      "eval (${pkgs.starship}/bin/starship init fish)";

    programs.fish.shellAbbrs.lvim = "NVIM_APPNAME=lvim nvim";

    # make fish default interactive shell
    home.sessionVariables.SHELL = lib.mkIf cfg.defaultInteractiveShell "fish";
    programs.kitty = lib.mkIf cfg.defaultInteractiveShell {
      settings.shell = "${lib.getExe pkgs.fish}";
    };

    programs.fzf.enable = true;
    programs.fzf.enableFishIntegration = true;

    home.packages = lib.mkIf cfg.withStarshipPrompt [
      pkgs.starship
    ];
  };
}
