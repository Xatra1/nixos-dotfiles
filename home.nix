{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [ <home-manager/nixos> ];

  home-manager.users.solarfire = {
    home = {
      username = "solarfire";
      homeDirectory = "/home/solarfire";
      stateVersion = "26.05";
    };

    programs = {
      home-manager.enable = true;

      fastfetch = {
        enable = true;
        settings = {
          "modules" = [
            "title"
            "separator"
            "os"
            "host"
            "kernel"
            "uptime"
            "packages"
            "shell"
            "display"
            "de"
            "wm"
            "wmtheme"
            "theme"
            "icons"
            "font"
            "cursor"
            "terminal"
            "terminalfont"
            "cpu"
            "gpu"
            "opengl"
            "vulkan"
            "memory"
            "swap"
            "disk"
            "localip"
            "locale"
            {
              type = "command";
              key = "Days since install";
              text = "echo $(( ($(date +%s) - $(date +%s -ud $(stat / | head -n 8 | tail -n 1 | awk '{print $2}'))) / 3600 / 24 ))";
            }
          ];
        };
      };

      git = {
        enable = true;
        settings = {
          user = {
            email = "xatra169@gmail.com";
            name = "solarfire";
          };
        };

        signing = {
          key = "D91D3C6966B4437A519F32471BA58E9D05F4AC54";
          signByDefault = true;
        };
      };

      kitty = {
        enable = true;
        autoThemeFiles.dark = "Argonaut";
        autoThemeFiles.light = "Argonaut";
        autoThemeFiles.noPreference = "Argonaut";

        font.name = "Miracode Nerdfont";
        font.size = 10;

        shellIntegration.mode = "no-title no-cursor";

        settings = {
          font_features = "MiracodeNF -liga";

          background_opacity = 0.5;
          background_blur = 1;

          scrollback_lines = 1000;
          wheel_scroll_multiplier = 1;

          cursor_shape = "block";
          cursor_blink_interval = 0.5;
          cursor_trail = 1;

          mouse_hide_wait = 3.0;
          detect_urls = "yes";
        };
      };

      mpv = {
        enable = true;
        config = {
          demuxer-max-bytes = "700000KiB";
          fs = "yes";
          use-filedir-conf = "yes";
          audio-display = "no";
          osd-font = "Miracode Nerd Font";
        };

        profiles = {
          "audio-files" = {
            profile-cond = "(filename:match\"%.mp3$\" or filename:match\"%.opus$\" or filename:match\"%.flac$\" or filename:match\"%.wav$\" or filename:match\"cdda://\")";
            script-opts = "osc-visibility=always";
          };
        };

        # why the FUCK are these flipped by default
        bindings = {
          PGUP = "add chapter -1";
          PGDWN = "add chapter 1";
        };
      };

      zsh = {
        enable = true;
        shellAliases = {
          dir = "dir -lshA --color=auto";
          prismlauncher = "prismlauncher -d ~/.local/share/PrismLauncher/";
          cat = "bat";
          fastfetch = "hyfetch";
        };

        dotDir = "/home/solarfire/.config/zsh";

        history = {
          append = true;
          ignoreAllDups = true;
          path = "/home/solarfire/.config/zsh-history";
          share = true;
          save = 10000;
          size = 10000;
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

        initContent = lib.mkOrder 1500 ''
          [[ "$TERM" = "linux" ]] && clear

          autoload -Uz select-word-style
          zstyle ':completion:*' menu select
          select-word-style bash

          export EDITOR=/run/current-system/sw/bin/nvim
          export SUDO_EDITOR=/run/current-system/sw/bin/nvim
          export PATH=$PATH:/home/solarfire/.local/bin:$CARGO_HOME/bin
          export THEME_PATH=$ZDOTDIR/themes
          export PLUGIN_PATH=$ZDOTDIR/plugins

          setopt interactivecomments

          source $THEME_PATH/burn.zsh-theme
          #source $THEME_PATH/burn-testing.zsh-theme

          BURN_BACKGROUND_COLOR_ERROR="#6a5496"
          BURN_BACKGROUND_COLOR_HOSTNAME="#b278d9"
          BURN_BACKGROUND_COLOR_DIR="#6a5496"
          BURN_FOREGROUND_COLOR_HOSTNAME="white"
          BURN_FOREGROUND_COLOR_DIR="white"

          source $PLUGIN_PATH/command-time.plugin.zsh
          source $PLUGIN_PATH/sudo.plugin.zsh

          ZSH_COMMAND_TIME_MIN_SECONDS=9
          ZSH_COMMAND_TIME_MSG="Command ran for %s."
          ZSH_COMMAND_TIME_COLOR="blue"

          source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh

          bindkey '^[OA' history-substring-search-up
          bindkey '^[[A' history-substring-search-up
          bindkey '^[OB' history-substring-search-down
          bindkey '^[[B' history-substring-search-down

          bindkey '^[[H' beginning-of-line
          bindkey '^[[F' end-of-line
          bindkey '^[^?' backward-kill-word
        '';
      };
    };
  };
}
