{
  programs.plasma.input = {
    keyboard.options = [ "caps:none" ];

     mice = [
      {
        name = "2.4G Wireless Keyboard Mouse"; # how creative
        vendorId = "3938";
        productId = "1208";
        acceleration = 0.3;
        scrollSpeed = 1.5;
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
}
