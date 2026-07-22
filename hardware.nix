{ pkgs, ... }:
{
  nixpkgs = {
    config.cudaSupport = true;
    hostPlatform = "x86_64-linux";
  };

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nvme"
      "usbhid"
      "sd_mod"
      "sr_mod"
      "rtsx_usb_sdmmc"
    ];

    kernelModules = [ "kvm-intel" ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/132aca4b-a790-4c5f-aa6d-b8a132411f88";
      fsType = "btrfs";
      options = [ "compress=zstd:6" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/D8E9-8F87";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/132aca4b-a790-4c5f-aa6d-b8a132411f88";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/5f96abe4-3d47-4e88-a237-77988b131879";
      fsType = "btrfs";
      options = [ "compress=zstd:3" ];
    };

    "/media" = {
      device = "/dev/disk/by-uuid/131a45e1-79c7-4a9b-a426-d04d8bea0a39";
      fsType = "btrfs";
    };

    "/media/jellyfin-data" = {
      device = "/dev/disk/by-uuid/9f10f71c-40bc-4b7a-bc77-46e6b44fee28";
      fsType = "btrfs";
      options = [ "compress=zstd:3" ];
    };

    "/media/backup-data" = {
      device = "/dev/disk/by-uuid/dec78277-1b28-40cc-8dd1-56db72db9e4b";
      fsType = "btrfs";
      options = [ "compress=zstd:3" ];
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/d6f79da8-54d7-403e-9586-205b3be063aa"; }
  ];

  services.udev.extraRules = ''
    ACTION=="add|change", KERNEL=="sd[a-z]*", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"
    ACTION=="add|change", KERNEL=="nvme[0-9]*", ENV{DEVTYPE}=="disk", ATTR{queue/scheduler}="bfq"
  '';

  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;

    nvidia = {
      branch = "bleeding_edge";
      open = true;
      powerManagement.enable = true;
    };

    graphics = {
      enable = true;

      extraPackages = with pkgs; [
        vpl-gpu-rt
        intel-media-driver
      ];
    };

    bluetooth.enable = true;
  };
}
