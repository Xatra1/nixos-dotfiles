{
  programs.git = {
    enable = true;

    settings = {
      user = {
        email = "xatra169@gmail.com";
        name = "solarfire";
      };

      push.autoSetupRemote = true;
    };

    signing = {
      key = "6910B53C231502CA24EC1BC8F07E41E6478387B2";
      signByDefault = true;
    };
  };
}
