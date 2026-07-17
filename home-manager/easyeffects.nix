let
  equalizerSettings = ''
    band0Frequency=63
    band0Gain=5
    band0Mode=6
    band0Q=1.37

    band1Frequency=250
    band1Gain=4
    band1Mode=6
    band1Q=1.37

    band2Frequency=250
    band2Gain=4
    band2Mode=6
    band2Q=1.37

    band3Frequency=500
    band3Gain=1
    band3Mode=6
    band3Q=1.37
  '';
in
{
  home-manager.users.solarfire.xdg.configFile = {
    "easyeffects/db/easyeffectsrc".text = ''
      [StreamOutputs]
      outputDevice=alsa_output.usb-Logitech_G535_Wireless_Gaming_Headset-00.analog-stereo
      plugins=equalizer#0
      visiblePage=pluginsPage
      visiblePlugin=equalizer#0

      [Window]
      height=1052
      width=1920
    '';

    "easyeffects/db/equalizerrc".text = ''
      [soe][Equalizer#0]
      inputGain=-5
      numBands=4

      [soe][Equalizer#0#left]
      ${equalizerSettings}

      [soe][Equalizer#0#right]
      ${equalizerSettings}
    '';
  };
}
