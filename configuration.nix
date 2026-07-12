{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./home-manager
    ./graphics.nix
    ./hardware-configuration.nix
    ./mountpoints.nix
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

  hardware = {
    cpu.intel.updateMicrocode = true;
    bluetooth.enable = true;
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

  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "daily";
    };
  };

  # boring nerd shit. dont change
  system.stateVersion = "26.05"; # Did you read the comment?

}
