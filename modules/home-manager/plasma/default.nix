{ config, ... }:
{
  imports = [
    ../../reused-strings.nix
    ./extra-config-files.nix
    ./kate.nix
    ./panels.nix
    ./theme-fetch.nix
    ./workspace.nix
  ];

  dconf = {
    enable = true;
    settings."desktop/ibus/panel".show-icon-on-systray = false;
  };

  programs.plasma = {
    enable = true;
    overrideConfig = true;

    input = {
      keyboard.options = [ "caps:none" ];

      touchpads = [
        {
          name = "ETPS/2 Elantech Touchpad";
          vendorId = "0002";
          productId = "000e";
          pointerSpeed = 0.3;
        }
      ];
    };

    kscreenlocker.appearance.wallpaper = config.wallpaper;

    shortcuts = {
      kwin = {
        "Window Minimize" = "Alt+F9";
        "Window Maximize" = "Alt+F10";
      };

      "services/kitty.desktop"."_launch" = "Ctrl+Alt+T";
      "services/org.kde.konsole.desktop"."_launch" = "None";
    };
  };
}
