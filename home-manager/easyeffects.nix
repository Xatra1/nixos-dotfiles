let
  equalizerSettings = ''
    band0Frequency=63
    band0Gain=9
    band0Mode=6
    band0Q=1.37
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
      inputGain=-10
      numBands=4

      [soe][Equalizer#0#left]
      ${equalizerSettings}

      [soe][Equalizer#0#right]
      ${equalizerSettings}
    '';
  };
}
