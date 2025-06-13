{
  config,
  pkgs,
  ...
}: let
  userModules = import ../../user;
  spotify-custom = pkgs.callPackage userModules.packages.spotify-spotx {};
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "emzy";
  home.homeDirectory = "/home/emzy";

  imports = [
    userModules.zsh
    userModules.qtile
    userModules.lazygit
    userModules.rofi
    userModules.hm
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  modules.fish = {
    enable = true;
    withStarshipPrompt = true;
    defaultInteractiveShell = true;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.9;
      font.size = 11;
      font.normal = {
        family = "JetBrainsMonoNerdFont";
        style = "Regular";
      };
    };
  };

  programs.kitty = {
    enable = true;
    font.name = "JetBrainsMono Nerd Font";
    font.size = 11;
    settings = {
      background_opacity = 0.8;
      confirm_os_window_close = 0;
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

  programs.btop = {
    enable = true;
    settings.vim_keys = true;
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio.override {cudaSupport = true;};
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

  services.hyprpolkitagent.enable = true;

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
    mimeApps.enable = true;
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
    kitty
    lazygit
    neofetch
    nh
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

    nerd-fonts.monaspace
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
