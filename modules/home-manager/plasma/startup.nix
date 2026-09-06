{ pkgs, ... }:
let
  headset-battery-indicator = pkgs.callPackage (pkgs.fetchurl {
    url = "https://codeberg.org/solarfire/nix-derivations/raw/branch/master/headset-battery-indicator/package.nix";
    hash = "sha256-z8zGKBhr8czdDvuXwWteKrdDrehcBXM5Sleu8g3XWAg=";
  }) { };
in
{
  xdg.configFile = {
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
      Exec=${pkgs.equibop}/bin/equibop --enable-smooth-scrolling --enable-blink-features=MiddleClickAutoscroll --enable-gpu-rasterization --enable-features=VaapiVideoDecodeLinuxGL --start-minimized
    '';

    "autostart/headset-battery-indicator.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=headset-battery-indicator
      Exec=${headset-battery-indicator}/bin/headset-battery-indicator
    '';

    "autostart/openrgb.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=OpenRGB
      Exec=${pkgs.openrgb-with-all-plugins}/bin/openrgb --startminimized
    '';

    "autostart/steam.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Steam
      Exec=${pkgs.steam}/bin/steam -silent
    '';
  };
}
