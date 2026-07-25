{ pkgs, ... }:
{
  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "usb_storage"
      "sd_mod"
    ];

    kernelModules = [ "kvm-intel" ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/7e4124a0-3a21-45eb-9bbe-9ede3b454f8a";
      fsType = "btrfs";
      options = [ "compress=zstd:6" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/5C5C-3A2C";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/7e4124a0-3a21-45eb-9bbe-9ede3b454f8a";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/7e4124a0-3a21-45eb-9bbe-9ede3b454f8a";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/d71aba65-2ffb-4e82-a013-edd247a9f329"; }
  ];

  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
    graphics.extraPackages = with pkgs; [ intel-media-driver ];
    bluetooth.enable = true;
  };
}
