{ config, ... }:
{
  imports = [
    ../../reused-strings.nix
    ./extra-config-files.nix
    ./input.nix
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
