{
  home-manager.users.solarfire.programs = {
    plasma.configFile = {
      katerc = {
        General = {
          "Startup Session" = "last";
          "Restore Window Configuration" = true;
        };

        project.restoreProjectsForSessions = true;
      };
    };

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
        brackets.automaticallyAddClosing = true;
      };
    };
  };
}
