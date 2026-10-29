let
  # The Amethyst color scheme for Konsole, converted into Kitty's theme format
  # by hand.
  themeFileContents = ''
    background #16162e
    foreground #fcfcfc
    cursor #5500ff

    color0 #232627
    color1 #ed1515
    color2 #11d116
    color3 #f67400
    color4 #1d99f3
    color5 #9b59b6
    color6 #5500ff
    color7 #fcfcfc
    color8 #7f8c8d
    color9 #c0392b
    color10 #1cdc9a
    color11 #fdbc4b
    color12 #3daee9
    color13 #8e44ad
    color14 #7741ff
    color15 #ffffff
  '';
in
{
  xdg.configFile = {
    "kitty/dark-theme.auto.conf".text = themeFileContents;
    "kitty/light-theme.auto.conf".text = themeFileContents;
    "kitty/no-preference-theme.auto.conf".text = themeFileContents;
  };

  programs.kitty = {
    enable = true;

    font.name = "Miracode Nerdfont";
    font.size = 10;

    shellIntegration.mode = "no-title no-cursor";

    settings = {
      font_features = "MiracodeNF -liga";

      background_opacity = 0.7;
      background_blur = 1;

      scrollback_lines = 5000;
      wheel_scroll_multiplier = 1;

      cursor_shape = "block";
      cursor_blink_interval = 0.5;
      cursor_trail = 1;

      mouse_hide_wait = 3.0;
      detect_urls = "yes";
    };
  };
}
