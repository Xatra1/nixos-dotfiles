{ pkgs, ... }:
{
  home-manager.users.solarfire.xdg.configFile = {
    "autostart/easyeffects.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Easy Effects
      Exec=${pkgs.easyeffects}/bin/easyeffects --hide-window --service-mode
    '';

    "autostart/discord.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Discord
      Exec=${pkgs.discord}/bin/discord --ozone-platform=wayland --enable-smooth-scrolling --enable-blink-features=MiddleClickAutoscroll --start-minimized
    '';

    "autostart/steam.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Steam
      Exec=${pkgs.steam}/bin/steam -silent
    '';
  };
}
