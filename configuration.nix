{ pkgs, ... }:
{
  imports = [
    ./home-manager
    ./hardware.nix
    ./packages.nix
    ./services.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;
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
    };
  };

  environment.sessionVariables = {
    XDG_CACHE_HOME = "/home/solarfire/.cache";
    XDG_CONFIG_HOME = "/home/solarfire/.config";
    XDG_STATE_HOME = "/home/solarfire/.local/state";
    XDG_DATA_HOME = "/home/solarfire/.local/share";

    CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv";

    GTK2_RC_FILES = "$XDG_CONFIG_HOME/gtk-2.0/gtkrc";
    WGETRC = "$XDG_CONFIG_HOME/wgetrc";

    HISTFILE = "$XDG_STATE_HOME/bash_history";

    ANDROID_USER_HOME = "$XDG_DATA_HOME/android";
    GNUPGHOME = "$XDG_DATA_HOME/gnupg";
    RUSTUP_HOME = "$XDG_DATA_HOME/rustup";
    CARGO_HOME = "$XDG_DATA_HOME/cargo";
    WINEPREFIX = "$XDG_DATA_HOME/wine";
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" ];
      use-xdg-base-directories = true;
      max-jobs = 1;
      cores = 16;
    };

    gc = {
      automatic = true;
      dates = "daily";
    };
  };

  nixpkgs = {
    config.cudaSupport = true;
    hostPlatform = "x86_64-linux";
  };

  # boring nerd shit. dont change
  system.stateVersion = "26.05"; # Did you read the comment?
}
