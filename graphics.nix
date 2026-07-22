{ pkgs, ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];
  nixpkgs.config.cudaSupport = true;

  hardware = {
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
  };
}
