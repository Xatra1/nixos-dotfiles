{
  programs.git = {
    enable = true;

    settings = {
      push.autoSetupRemote = true;

      user = {
        email = "xatra169@gmail.com";
        name = "solarfire";
      };
    };

    signing = {
      key = "6910B53C231502CA24EC1BC8F07E41E6478387B2";
      signByDefault = true;
    };
  };
}
