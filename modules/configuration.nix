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

    kernelPackages = pkgs.linuxPackages_latest;
    zswap.enable = true;
  };

  networking = {
    hostName = "lemon";
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

      extraGroups = [
        "networkmanager"
        "wheel"
        "media"
      ];

      shell = pkgs.zsh;
      hashedPassword = "$y$j9T$CzrASqEyw1R3dmzdt/k4D1$ZvRgupEHnpzAkhYwL8smD3M1dbtAoMbnJLxCctadn.A";
    };
  };

  nix = {
    settings = {
      auto-optimise-store = true;

      experimental-features = [
        "nix-command"
        "flakes"
      ];

      use-xdg-base-directories = true;
      max-jobs = 1;
      cores = 16;
      warn-dirty = false;
    };
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  # boring nerd shit. dont change
  system.stateVersion = "26.05"; # Did you read the comment?
}
