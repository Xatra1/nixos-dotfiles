{
  imports = [
    ./plasma
    ./btop.nix
    ./equibop.nix
    ./fastfetch.nix
    ./hyfetch.nix
    ./kitty.nix
    ./mpv.nix
    ./xdg-base-dir.nix
    ./zsh.nix
  ];

  home = {
    username = "solarfire";
    homeDirectory = "/home/solarfire";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
}
