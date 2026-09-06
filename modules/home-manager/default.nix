{
  imports = [
    ./plasma
    ./btop.nix
    ./easyeffects.nix
    ./equibop.nix
    ./fastfetch.nix
    ./git.nix
    ./headset-battery-indicator.nix
    ./hyfetch.nix
    ./kitty.nix
    ./mpv.nix
    ./ssh.nix
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
