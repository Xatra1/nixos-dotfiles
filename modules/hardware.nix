{ pkgs, ... }:
{
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
      device = "/dev/disk/by-uuid/d8caa12a-e5b4-4a71-8265-79b083aafe61";
      fsType = "btrfs";
      options = [ "compress=zstd:9" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/1585-03D8";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/d8caa12a-e5b4-4a71-8265-79b083aafe61";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/b01e186c-cf65-4b42-9f2f-d96ffa6052d6";
      fsType = "btrfs";
      options = [ "compress=zstd:9" ];
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
      options = [ "compress=zstd:9" ];
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/0c268b87-ba9a-4175-8618-59b6176a99e7"; }
  ];

  services.udev.extraRules = "ACTION==\"add|change\", KERNEL==\"sd[a-z]*\", ATTR{queue/rotational}==\"1\", ATTR{queue/scheduler}=\"bfq\"";

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
