{
  programs.plasma = {
    configFile.kcminputrc = {
      "Libinput/Libinput/16700/12314/PixArt Dell MS116 USB Optical Mouse".ScrollMethod = 4;
      "Libinput/2/14/ETPS\\/2 Elantech Touchpad".DisableEventsOnExternalMouse = true;
    };

    input = {
      keyboard.options = [ "caps:none" ];

      mice = [
        {
          name = "PixArt Dell MS116 USB Optical Mouse";
          vendorId = "413C";
          productId = "301A";
          acceleration = 0.3;
          scrollSpeed = 1.5;
          middleButtonEmulation = true;
        }
      ];

      touchpads = [
        {
          name = "ETPS/2 Elantech Touchpad";
          vendorId = "0002";
          productId = "000e";
          pointerSpeed = 0.3;
        }
      ];
    };
  };
}
