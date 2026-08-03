{ config, ... }:
{
  imports = [ ../../reused-strings.nix ];

  programs.plasma.panels = [
    {
      location = "top";
      height = 56;
      lengthMode = "fill";
      hiding = "dodgewindows";
      floating = true;

      widgets = [
        {
          name = "org.kde.plasma.pager";
        }

        {
          systemMonitor = {
            displayStyle = "org.kde.ksysguard.horizontalbars";
            sensors = [
              {
                name = "cpu/all/usage";
                color = "0,170,255";
                label = "CPU Usage";
              }

              {
                name = "gpu/gpu0/usage";
                color = "0,255,0";
                label = "GPU Usage";
              }

              {
                name = "memory/physical/used";
                color = "255,0,0";
                label = "RAM Usage";
              }

              {
                name = "memory/swap/used";
                color = "255,0,127";
                label = "Swap Usage";
              }
            ];
          };
        }

        {
          systemMonitor = {
            displayStyle = "org.kde.ksysguard.textonly";
            sensors = [
              {
                name = "cpu/all/averageTemperature";
                color = "0,170,255";
                label = config.hardwareInfo.cpuName;
              }
            ];
          };
        }

        {
          name = "org.kde.plasma.panelspacer";
        }

        {
          digitalClock = {
            date = {
              enable = true;
              format = "isoDate";
            };

            time.format = "12h";
          };
        }

        {
          name = "org.kde.plasma.panelspacer";
        }

        {
          systemTray = {
            items.hidden = [
              "org.kde.plasma.battery"
              "org.kde.plasma.clipboard"
              "org.kde.plasma.mediacontroller"
              "org.kde.plasma.devicenotifier"
            ];
          };
        }
      ];
    }

    {
      location = "bottom";
      height = 56;
      lengthMode = "fit";
      hiding = "dodgewindows";
      floating = true;

      widgets = [
        {
          name = "org.kde.plasma.kickoff";

          config = {
            General = {
              icon = "nix";
              highlightNewlyInstalledApps = false;
            };
          };
        }

        {
          iconTasks = {
            appearance.iconSpacing = "medium";

            launchers = [
              "preferred://browser"
              "preferred://filemanager"
              "applications:kitty.desktop"
              "applications:discord.desktop"
              "applications:systemsettings.desktop"
            ];
          };
        }
      ];
    }
  ];
}
