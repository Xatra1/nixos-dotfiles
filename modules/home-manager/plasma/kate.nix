{
  xdg.configFile = {
    "kate/formatting/settings.json".text = ''
      {
        "nixfmt": {
          "command": [
            "nixfmt",
            "-"
          ]
        }
      }
    '';

    # home-manager will silently ignore this block if the filepath is
    # "kate/lspclient/settings.json", even when that file doesn't exist. I
    # have no idea why the hell this is the case.
    "kate/lspclient/totally-not-settings.json".text = ''
      {
        "servers": {
          "css": {
            "command": [
              "vscode-css-language-server",
              "--stdio"
            ],

            "url": "https://github.com/Microsoft/vscode/tree/main/extensions/css-language-features/server",
            "highlightingModeRegex": "^CSS$"
          },

          "html": {
            "command": [
              "vscode-html-language-server",
              "--stdio"
            ],

            "url": "https://github.com/Microsoft/vscode/tree/main/extensions/html-language-features/server",
            "highlightingModeRegex": "^HTML$"
          },

          "json": {
            "command": [
              "vscode-json-language-server",
              "--stdio"
            ],

            "url": "https://github.com/microsoft/vscode/tree/main/extensions/json-language-features/server",
            "highlightingModeRegex": "^JSON$"
          },

          "Slint": {
            "command": [ "slint-lsp" ],
            "highlightingModeRegex": "Slint"
          }
        }
      }
    '';
  };

  programs = {
    plasma.configFile.katerc = {
      project.restoreProjectsForSessions = true;
      lspclient.ServerConfiguration = "file:///home/solarfire/.config/kate/lspclient/totally-not-settings.json"; # see above comment

      General = {
        "Startup Session" = "last";
        "Restore Window Configuration" = true;
        "Show output view for message type" = 0;
      };

      Konsole = {
        AutoSyncronizeMode = 1; # its spelled wrong in katerc lol
        KonsoleEscKeyBehaviour = false;
      };
    };

    kate = {
      enable = true;

      editor = {
        tabWidth = 2;
        indent.replaceWithSpaces = true;
        theme.name = "Tokyo Night";
        brackets.automaticallyAddClosing = true;

        font = {
          family = "Miracode Nerd Font";
          pointSize = 9;
        };
      };
    };
  };
}
