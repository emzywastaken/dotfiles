{
  pkgs,
  lib,
  ...
}: {
  home.username = "emzy";
  home.homeDirectory = "/home/emzy";

  imports = [
    ../user
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
      background_opacity = lib.mkDefault 0.8;
      confirm_os_window_close = 0;
    };
    keybindings = {
      "ctrl+f2" = "detach_tab";
      "ctrl+f3" = "detach_tab ask";
    };
  };

  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      user.email = "amiamemetoo@gmail.com";
      user.name = "emzywastaken";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      dark = true;
      line-numbers = true;
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

  programs.anki.enable = true;

  programs.element-desktop.enable = true;

  programs.mpv.enable = true;

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

  services.gnome-keyring.enable = true;
  services.syncthing.enable = true;

  home.packages = with pkgs;
    [
      custom.spotify

      bat
      (bottles.override {removeWarningPopup = true;})
      discord
      fastfetch
      (google-chrome.override {
        commandLineArgs = [
          (lib.concatStringsSep "," [
            "--enable-features=TouchpadOverscrollHistoryNavigation"
            "AcceleratedVideoEncoder"
          ])
          "--ignore-gpu-blocklist"
          "--enable-zero-copy"
        ];
      })
      ghc
      cabal-install
      gleam
      erlang # gleam need erlang
      file-roller
      kitty
      neofetch
      nh
      obsidian
      opam # ocaml
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

      (pkgs.writeShellScriptBin "ulink" ''
        for arg in "$@"; do
            if [[ -L "$arg" ]]; then
                cp --remove-destination "$(readlink -f "$arg")" "$arg"
                chmod u+w "$arg"
                echo "$arg is now unlinked and writable"
            else
                echo "Skipping: $arg is not a symlink"
            fi
        done
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
      statix
      haskell-language-server
    ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
