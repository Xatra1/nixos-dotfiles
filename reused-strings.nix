{ lib, ... }:
{
  options = {
    wallpaper = lib.mkOption {
      type = lib.types.str;
      default = "/home/solarfire/Pictures/Wallpapers/98.png";
      description = "Absolute path to an image.";
    };

    hardwareInfo = {
      cpuName = lib.mkOption {
        type = lib.types.str;
        default = "Intel Core i3-6100U";
        description = "Custom CPU name.";
      };

      gpuNames = lib.mkOption {
        type = with lib.types; listOf str;

        default = [
          "Intel Graphics HD 520"
        ];

        description = "List of custom names for each GPU.";
      };
    };
  };
}
