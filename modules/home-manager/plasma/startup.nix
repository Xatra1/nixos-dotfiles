{ pkgs, ... }:
{
  xdg.configFile = {
    "autostart/steam.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Steam
      Exec=${pkgs.steam}/bin/steam
    '';
  };
}
