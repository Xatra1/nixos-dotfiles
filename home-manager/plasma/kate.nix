{
  home-manager.users.solarfire = {
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
                }
            }
        }
      '';
    };

    programs = {
      plasma.configFile.katerc = {
        General = {
          "Startup Session" = "last";
          "Restore Window Configuration" = true;
        };

        Konsole.KonsoleEscKeyBehavior = false;
        project.restoreProjectsForSessions = true;
        lspclient.ServerConfiguration = "file:///home/solarfire/.config/kate/lspclient/totally-not-settings.json"; # see above comment
      };

      kate = {
        enable = true;

        editor = {
          tabWidth = 2;
          indent.replaceWithSpaces = true;

          font = {
            family = "Miracode Nerd Font";
            pointSize = 9;
          };

          theme.name = "ayu Mirage";
          brackets.automaticallyAddClosing = true;
        };
      };
    };
  };
}
