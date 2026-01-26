{
  pkgs,
  lib,
  ...
}: {
  home.username = "emzy";
  home.homeDirectory = "/home/emzy";

  home.stateVersion = "24.11";

  home.shell.enableShellIntegration = false;

  programs.kitty = {
    enable = true;
    font.name = "JetBrainsMono Nerd Font";
    font.size = 11;
    settings = {
      background_opacity = lib.mkDefault 0.8;
      confirm_os_window_close = 0;
      scrollback_pager_history_size = 5;
    };
    keybindings = {
      "ctrl+f2" = "detach_tab";
      "ctrl+f3" = "detach_tab ask";
    };
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
  };

  services.syncthing.enable = true;

  home.packages = with pkgs;
    [
      custom.spotify
      custom.helium

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
      gajim
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
}
