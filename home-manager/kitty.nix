{
  home-manager.users.solarfire.programs.kitty = {
    enable = true;
    autoThemeFiles.dark = "Argonaut";
    autoThemeFiles.light = "Argonaut";
    autoThemeFiles.noPreference = "Argonaut";

    font.name = "Miracode Nerdfont";
    font.size = 10;

    shellIntegration.mode = "no-title no-cursor";

    settings = {
      font_features = "MiracodeNF -liga";

      background_opacity = 0.7;
      background_blur = 1;

      scrollback_lines = 1000;
      wheel_scroll_multiplier = 1;

      cursor_shape = "block";
      cursor_blink_interval = 0.5;
      cursor_trail = 1;

      mouse_hide_wait = 3.0;
      detect_urls = "yes";
    };
  };
}
