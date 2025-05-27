{  pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "ls --color";
      ll = "ls -lh";
      la = "ls -lAh";
      lvim = "NVIM_APPNAME=lvim nvim";
    };

    history = rec {
      append = true;
      findNoDups = true;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      saveNoDups = true;
      share = true;
      save = size;
      size = 5000;
    };

    plugins = [
      { name = "fzf-tab"; src = pkgs.zsh-fzf-tab.src; }
    ];

    initContent = ''
      export PATH="$PATH:$HOME/.zvm/bin"

      HISTDUP=erase

      # Completion styling
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
      zstyle ':completion:*' menu no

      eval "$(${pkgs.starship}/bin/starship init zsh)"
      eval "$(${pkgs.fzf}/bin/fzf --zsh)"
    '';
  };

  home.packages =  [
    pkgs.starship
  ];
}
