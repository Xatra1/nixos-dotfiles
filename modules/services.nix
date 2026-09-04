{ pkgs, ... }:
{
  security.rtkit.enable = true;

  services = {
    displayManager.plasma-login-manager.enable = true;
    desktopManager.plasma6.enable = true;
    flatpak.enable = true;
    tailscale.enable = true;
    openssh.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    locate = with pkgs; {
      enable = true;
      package = plocate;
    };
  };
}
