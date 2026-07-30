{ pkgs, ... }:
{
  home-manager.users.solarfire.xdg.configFile = {
    "autostart/easyeffects.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Easy Effects
      Exec=${pkgs.easyeffects}/bin/easyeffects --hide-window --service-mode
    '';

    "autostart/equibop.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Equibop
      Exec=${pkgs.equibop}/bin/equibop --start-minimized
    '';

    "autostart/steam.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Steam
      Exec=${pkgs.steam}/bin/steam -silent
    '';
  };
}
