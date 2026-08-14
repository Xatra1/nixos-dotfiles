{
  imports = [
    ./plasma
    ./btop.nix
    ./fastfetch.nix
    ./git.nix
    ./hyfetch.nix
    ./kitty.nix
    ./mpv.nix
    ./xdg-base-dir.nix
    ./zsh.nix
  ];

  nixpkgs.config.allowUnfree = true; # "home-manager switch" wont work if this isnt also set here

  home = {
    username = "solarfire";
    homeDirectory = "/home/solarfire";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
}
