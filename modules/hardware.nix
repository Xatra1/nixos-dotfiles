{
  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "ehci_pci"
      "sd_mod"
      "sr_mod"
      "rtsx_usb_sdmmc"
    ];

    kernelModules = [ "kvm-amd" ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/1e266b48-166b-4e7b-9be5-b0c9b0746be8";
      fsType = "btrfs";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/97D4-6D41";
      fsType = "vfat";

      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/1e266b48-166b-4e7b-9be5-b0c9b0746be8";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/1e266b48-166b-4e7b-9be5-b0c9b0746be8";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/4c042d92-5c78-4049-bbff-e585c2f227ae"; }
  ];

  services.udev.extraRules = "ACTION==\"add|change\", KERNEL==\"sd[a-z]*\", ATTR{queue/rotational}==\"1\", ATTR{queue/scheduler}=\"bfq\"";

  hardware = {
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;
    bluetooth.enable = true;
  };
}
