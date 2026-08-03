{ config, ... }:
{
  imports = [ ../../reused-strings.nix ];

  programs.plasma.workspace = {
    enableMiddleClickPaste = false;
    theme = "Amethyst";
    colorScheme = "TokyoNight";
    iconTheme = "Tela-circle-dark";
    wallpaper = config.wallpaper;
    cursor.theme = "Oxygen 08 Indigo";

    windowDecorations = {
      library = "org.kde.breeze";
      theme = "Breeze";
    };
  };
}
