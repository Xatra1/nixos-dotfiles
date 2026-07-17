{
  home-manager.users.solarfire.programs.hyfetch = {
    enable = true;

    settings = {
      preset = "pansexual";
      mode = "rgb";
      light_dark = "dark";
      lightness = 0.5;
      color_align.mode = "vertical";
      backend = "fastfetch";
      pride_month_disable = false;
    };
  };
}
