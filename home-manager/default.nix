{
  imports = [
    <home-manager/nixos>
    ./plasma
    ./btop.nix
    ./easyeffects.nix
    ./fastfetch.nix
    ./git.nix
    ./hyfetch.nix
    ./kitty.nix
    ./mpv.nix
    ./zsh.nix
  ];

  home-manager.users.solarfire = {
    home = {
      username = "solarfire";
      homeDirectory = "/home/solarfire";
      stateVersion = "26.05";
    };

    programs.home-manager.enable = true;
  };
}
