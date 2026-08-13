{
  pkgs,
  lib,
  ...
}:
let
  burn = fetchGit {
    url = "https://codeberg.org/solarfire/burn";
    rev = "194fde56a86ba2e408593840d2382c4630a41b6e";
  };

  command-time = pkgs.fetchFromGitHub {
    owner = "popstas";
    repo = "zsh-command-time";
    rev = "f163ac1d41f8645d1d055393e52692e2ee185e5f";
    hash = "sha256-6Dy5uCzLgBJZIepFvylPhsaK4URinAwbJW7XmSBGj7M=";
  };

  oh-my-zsh = pkgs.fetchFromGitHub {
    owner = "ohmyzsh";
    repo = "ohmyzsh";
    rev = "ad586ffecaaeb695cc73ced4d643c6727d47f535";
    hash = "sha256-3o0G6f5kyetOx7brvqZTim3eQBMTpi2wU2vgQ54cvlk=";
  };

  burnConfig = ''
    BURN_BACKGROUND_COLOR_ERROR="red"
    BURN_BACKGROUND_COLOR_HOSTNAME="black"
    BURN_BACKGROUND_COLOR_DIR="#5fff87"

    BURN_FOREGROUND_COLOR_ERROR="white"
    BURN_FOREGROUND_COLOR_HOSTNAME="#5fff87"
    BURN_FOREGROUND_COLOR_DIR="black"
  '';
in
{
  xdg.configFile = {
    "zsh/themes/burn.zsh-theme".source = "${burn}/burn.zsh-theme";
    "zsh/plugins/command-time.plugin.zsh".source = "${command-time}/command-time.plugin.zsh";
    "zsh/plugins/sudo.plugin.zsh".source = "${oh-my-zsh}/plugins/sudo/sudo.plugin.zsh";
    "zsh/plugins/history-substring-search/".source = "${oh-my-zsh}/plugins/history-substring-search";
  };

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;

    shellAliases = {
      # https://github.com/nix-community/plasma-manager/issues/195
      fix_panels = "rm ~/.local/share/plasma-manager/last_run_*; ~/.local/share/plasma-manager/run_all.sh";
      adb = "HOME=\"$XDG_DATA_HOME\"/android adb";
      dir = "dir -lshA --color=auto";
      cat = "bat";
      fastfetch = "hyfetch";
    };

    dotDir = "/home/solarfire/.config/zsh";

    history = {
      append = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      path = "/home/solarfire/.config/zsh/zsh-history";
      share = true;
      size = 1000000000;
      save = 1000000000;
    };

    syntaxHighlighting = {
      enable = true;

      highlighters = [
        "main"
        "brackets"
        "pattern"
      ];

      styles = {
        default = "none";
        unknown-token = "fg=red";
        reserved-word = "fg=cyan,bold";
        suffix-alias = "fg=green,underline";
        global-alias = "fg=green,bold";
        precommand = "fg=green,underline";
        commandseparator = "fg=blue,bold";
        autodirectory = "fg=green,underline";
        path = "bold";
        path_pathseparator = "none";
        path_prefix_pathseparator = "none";
        globbing = "fg=blue,bold";
        history-expansion = "fg=blue,bold";
        command-substitution = "none";
        command-substitution-delimiter = "fg=magenta,bold";
        process-substitution = "none";
        process-substitution-delimiter = "fg=magenta,bold";
        single-hyphen-option = "fg=green";
        double-hyphen-option = "fg=green";
        back-quoted-argument = "none";
        back-quoted-argument-delimiter = "none";
        single-quoted-argument = "fg=yellow";
        double-quoted-argument = "fg=yellow";
        dollar-quoted-argument = "fg=yellow";
        rc-quote = "fg=magenta";
        dollar-double-quoted-argument = "fg=magenta,bold";
        back-double-quoted-argument = "fg=magenta,bold";
        back-dollar-quoted-argument = "fg=magneta,bold";
        assign = "none";
        redirection = "fg=blue,bold";
        comment = "fg=black,bold";
        named-fd = "none";
        numeric-fd = "none";
        arg0 = "fg=cyan";
        bracket-error = "fg=red,bold";
        bracket-level-1 = "fg=blue,bold";
        bracket-level-2 = "fg=green,bold";
        bracket-level-3 = "fg=magenta,bold";
        bracket-level-4 = "fg=yellow,bold";
        bracket-level-5 = "fg=cyan,bold";
        cursor-matchingbracket = "standout";
      };
    };

    completionInit = ''
      autoload -Uz compinit

      for dump in $ZDOTDIR/.zcompdump(N.mh+24); do
        compinit
      done

      compinit -C
    '';

    initContent = lib.mkOrder 1500 ''
      [[ "$TERM" = "linux" ]] && clear

      autoload -Uz select-word-style
      zstyle ':completion:*' menu select
      select-word-style bash

      autoload edit-command-line
      zle -N edit-command-line
      bindkey '^X^E' edit-command-line

      export PATH=$PATH:/home/solarfire/.local/bin:$CARGO_HOME/bin
      export THEME_PATH=$ZDOTDIR/themes
      export PLUGIN_PATH=$ZDOTDIR/plugins
      export NH_FLAKE="/home/solarfire/Documents/Projects/nixos-dotfiles"

      setopt interactivecomments

      ${burnConfig}
      source $THEME_PATH/burn.zsh-theme

      source $PLUGIN_PATH/sudo.plugin.zsh

      source $PLUGIN_PATH/command-time.plugin.zsh
      ZSH_COMMAND_TIME_MIN_SECONDS=9
      ZSH_COMMAND_TIME_MSG="Command ran for %s."
      ZSH_COMMAND_TIME_COLOR="blue"

      source $PLUGIN_PATH/history-substring-search/history-substring-search.plugin.zsh
      bindkey '^[OA' history-substring-search-up
      bindkey '^[[A' history-substring-search-up
      bindkey '^[OB' history-substring-search-down
      bindkey '^[[B' history-substring-search-down

      bindkey '^[[H' beginning-of-line
      bindkey '^[[F' end-of-line
      bindkey '^[^?' backward-kill-word
    '';
  };
}
