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
  };

  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
    bluetooth.enable = true;

    nvidia = {
      branch = "bleeding_edge";
      open = true;
      powerManagement.enable = true;
    };
  };
}
