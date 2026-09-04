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
      key = "D91D3C6966B4437A519F32471BA58E9D05F4AC54";
      signByDefault = true;
    };
  };
}
