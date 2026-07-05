{
  home-manager.users.solarfire.programs.fastfetch = {
    enable = true;
    settings = {
      "modules" = [
        "title"
        "separator"
        {
          type = "command";
          key = "OS";
          text = "source /etc/os-release; echo \"$PRETTY_NAME Generation $(readlink /nix/var/nix/profiles/system | grep -o \"[0-9]*\")\"";
        }
        "host"
        "kernel"
        "uptime"
        "packages"
        "shell"
        "display"
        "de"
        "wm"
        "wmtheme"
        "theme"
        "icons"
        "font"
        "cursor"
        "terminal"
        "terminalfont"
        "cpu"
        "gpu"
        "memory"
        "swap"
        "disk"
        "localip"
        "locale"
        {
          type = "command";
          key = "Days since install";
          text = "echo $(( ($(date +%s) - $(date +%s -ud $(stat / | head -n 8 | tail -n 1 | awk '{print $2}'))) / 3600 / 24 ))";
        }
      ];
    };
  };
}
