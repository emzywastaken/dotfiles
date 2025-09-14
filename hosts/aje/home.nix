{pkgs, ...}: let
  userModules = import ../../user;
in {
  home.username = "emzy";
  home.homeDirectory = "/home/emzy";

  imports = [
    userModules.zsh
    userModules.qtile
    userModules.lazygit
    userModules.rofi
    userModules.hm
  ];

  home.stateVersion = "24.11";

  home.shell.enableShellIntegration = false;

  modules.fish = {
    enable = true;
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
    keybindings = {
      "ctrl+f2" = "detach_tab";
      "ctrl+f3" = "detach_tab ask";
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
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    size = 24;
    name = "Bibata-Modern-Ice";
  };

  gtk = {
    enable = true;
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

  services.dunst = {
    enable = true;
    settings = {
      global = {
        corner_radius = 10;
      };
    };
  };
  services.network-manager-applet.enable = true;
  services.hyprpolkitagent.enable = true;

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
    terminal-exec = {
      enable = true;
      settings = {
        default = ["kitty.desktop"];
      };
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = ["org.pwmt.zathura-pdf-mupdf.desktop"];
        "image/png" = ["com.interversehq.qView.desktop"];
        "image/jpeg" = ["com.interversehq.qView.desktop"];
        "inode/directory" = ["thunar.desktop"];
        "video/mp4" = ["vlc.desktop"];
      };
    };
  };

  home.packages = with pkgs;
    [
      custom.spotify

      bat
      (bottles.override {removeWarningPopup = true;})
      blender
      discord
      fastfetch
      (google-chrome.override {
        commandLineArgs = [
          "--enable-features=TouchpadOverscrollHistoryNavigation"
        ];
      })
      gleam
      erlang # gleam need erlang
      kdePackages.ark
      kitty
      lazygit
      neofetch
      nh
      obsidian
      opam
      osu-lazer-bin
      qbittorrent
      qview
      razer-cli
      tealdeer
      telegram-desktop
      tokei
      tree
      unrar
      vesktop
      vlc
      yazi
      zathura
      zed-editor
      zvm

      nerd-fonts.monaspace

      (pkgs.writeShellScriptBin "snip" ''
        ${pkgs.grim}/bin/grim -l 0 -g "$(${pkgs.slurp}/bin/slurp)" - | wl-copy
      '')

      (pkgs.writeShellApplication {
        name = "ns";
        runtimeInputs = with pkgs; [
          fzf
          nix-search-tv
        ];
        # prevent IFD, thanks @Michael-C-Buckley
        text = ''exec "${pkgs.nix-search-tv.src}/nixpkgs.sh" "$@"'';
      })
    ]
    # lsp + fmt
    ++ [
      lua-language-server
      stylua
      taplo
      nixd
      alejandra
    ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
