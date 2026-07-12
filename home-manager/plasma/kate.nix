{
  home-manager.users.solarfire.programs = {
    kate = {
      enable = true;

      editor = {
        tabWidth = 2;
        indent.replaceWithSpaces = true;

        font = {
          family = "Miracode Nerd Font";
          pointSize = 9;
        };

        theme.name = "ayu Mirage";
      };
    };
  };
}
