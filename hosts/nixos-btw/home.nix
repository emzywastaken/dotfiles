{ config, pkgs, ... }:

let
  userModules = import ../../user;
  spotify-custom = pkgs.callPackage userModules.packages.spotify-spotx {};
in 
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "emzy";
  home.homeDirectory = "/home/emzy";

  imports = [ userModules.zsh  userModules.qtile  userModules.lazygit userModules.rofi ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.9;
      font.size = 9;
      font.normal = {
        family = "JetBrainsMonoNerdFont";
        style = "Regular";
      };
    };
  };

  programs.git = {
    enable = true;
    userName = "emzywastaken";
    userEmail = "amiamemetoo@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio.override { cudaSupport = true; };
  };

  services.network-manager-applet.enable = true;

  gtk = {
    enable = true;
    cursorTheme.package = pkgs.bibata-cursors;
    cursorTheme.name = "Bibata-Modern-Ice";

    theme.package = pkgs.adw-gtk3;
    theme.name = "adw-gtk3-dark";

    iconTheme.package = pkgs.gruvbox-plus-icons;
    iconTheme.name = "Gruvbox-Plus-Dark";
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    bat
    blender_4_4
    fastfetch
    (google-chrome.override {
      commandLineArgs = [
        "--enable-features=TouchpadOverscrollHistoryNavigation"
      ];
    })
    lazygit
    neofetch
    nixd # nix lsp
    obsidian
    qbittorrent
    qview
    spotify-custom
    tokei
    tree
    vlc
    yazi
    zathura
    zvm

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];


  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/emzy/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
