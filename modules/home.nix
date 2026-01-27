{
  pkgs,
  lib,
  ...
}: {
  imports = [(lib.mkAliasOptionModule ["hj"] ["hjem" "users" "emzy"])];

  hjem = {
    clobberByDefault = true;
    users.emzy = {
      enable = true;
      # this interferes with home-manager's systemd unit management
      systemd.enable = false;
    };
  };

  hj.packages = with pkgs;
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
