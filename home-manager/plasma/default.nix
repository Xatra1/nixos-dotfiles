{ config, ... }:
{
  imports = [
    ../../reused-strings.nix
    ./extra-config-files.nix
    ./kate.nix
    ./panels.nix
    ./startup.nix
    ./theme-fetch.nix
    ./workspace.nix
  ];

  home-manager.users.solarfire = {
    imports = [ <plasma-manager/modules> ];

    programs.plasma = {
      enable = true;
      overrideConfig = true;
      input.keyboard.numlockOnStartup = "on";

      kscreenlocker = {
        autoLock = false;
        appearance.wallpaper = config.wallpaper;
      };

      shortcuts = {
        kwin = {
          "Window Minimize" = "Alt+F9";
          "Window Maximize" = "Alt+F10";
        };
        "services/kitty.desktop"."_launch" = "Ctrl+Alt+T";
        "services/org.kde.konsole.desktop"."_launch" = "None";
      };

      powerdevil.AC = {
        autoSuspend.action = "nothing";
        turnOffDisplay.idleTimeout = "never";
        dimDisplay.enable = false;
      };
    };
  };
}
