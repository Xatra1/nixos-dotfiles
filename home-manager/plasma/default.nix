{
  imports = [
    ./extra-config-files.nix
    ./panels.nix
    ./startup.nix
    ./workspace.nix
  ];

  home-manager.users.solarfire = {
    imports = [ <plasma-manager/modules> ];
    programs = {
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
        };
      };

      plasma = {
        enable = true;
        overrideConfig = true;
        input.keyboard.numlockOnStartup = "on";

        kscreenlocker = {
          autoLock = false;
          appearance.wallpaper = "/home/solarfire/Pictures/Wallpapers/97.jpg";
        };

        shortcuts = {
          kwin = {
            "Minimize Window" = "Alt+F9";
            "Maximize Window" = "Alt+F10";
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
  };
}
