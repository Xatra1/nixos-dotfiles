{
  home-manager.users.solarfire.programs.ssh = {
    enable = true;

    settings = {
      "lemon" = {
        User = "solarfire";
        IdentityFile = "~/.ssh/ssh";
        IdentitiesOnly = "yes";
      };

      "github.com" = {
        User = "solarfire";
        IdentityFile = "~/.ssh/github";
        IdentitiesOnly = "yes";
      };
    };
  };
}
