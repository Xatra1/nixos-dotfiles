{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./graphics.nix
    ./hardware-configuration.nix
    ./home.nix
    ./mountpoints.nix
    ./packages.nix
    ./services.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "lemon";

  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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

  users.users."solarfire" = {
    isNormalUser = true;
    description = "skrimmy mcbimmy";
    extraGroups = [
      "networkmanager"
      "wheel"
      "media"
    ];
  };

  hardware.cpu.intel.updateMicrocode = true;

  nix.settings.auto-optimise-store = true;

  # boring nerd shit. dont change
  system.stateVersion = "26.05"; # Did you read the comment?

}
