{ pkgs, ... }:
{
  imports = [
    ./hardware.nix
    ./packages.nix
    ./plasma-overlay.nix
    ./services.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_zen;
    zswap.enable = true;
  };

  networking = {
    hostName = "strawberry";
    networkmanager.enable = true;
  };

  time.timeZone = "America/New_York";

  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  users.users = {
    "solarfire" = {
      isNormalUser = true;
      description = "skrimmy mcbimmy";
      shell = pkgs.zsh;

      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      use-xdg-base-directories = true;
      max-jobs = 1;
      cores = 4;
      warn-dirty = false;
      substituters = [ "http://lemon:8080?priority=100" ];
      trusted-public-keys = [ "lemon-1:HDAKLAuAFxJGPLnbnGBI9j9FDYqe04WeTlBWb3Z7UxE=" ];

      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  # boring nerd shit. dont change
  system.stateVersion = "26.05"; # Did you read the comment?
}
