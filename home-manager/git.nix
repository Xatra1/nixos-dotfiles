{
  home-manager.users.solarfire.programs.git = {
    enable = true;

    settings = {
      user = {
        email = "xatra169@gmail.com";
        name = "solarfire";
      };
    };

    signing = {
      key = "96DE7A270AFFCEC34FEBDC60F4982543351CAC49";
      signByDefault = true;
    };
  };
}
