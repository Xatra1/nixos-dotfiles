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
        default = "AMD A12-9700P";
        description = "Custom CPU name.";
      };

      gpuNames = lib.mkOption {
        type = with lib.types; listOf str;

        default = [
          "AMD Radeon R7 Graphics"
        ];

        description = "List of custom names for each GPU.";
      };
    };
  };
}
