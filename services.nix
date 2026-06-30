{ pkgs, ... }:
{
  services.udev.extraRules = ''
    ACTION=="add|change", KERNEL=="sd[a-z]*", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"
    ACTION=="add|change", KERNEL=="nvme[0-9]*", ENV{DEVTYPE}=="disk", ATTR{queue/scheduler}="bfq"
  '';

  services.displayManager.plasma-login-manager.enable = true;
  services.desktopManager.plasma6.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.flatpak.enable = true;
  services.lact.enable = true;
  services.tailscale.enable = true;

  services.sonarr.enable = true;
  users.users."sonarr".extraGroups = [ "media" ];

  services.radarr.enable = true;
  users.users."radarr".extraGroups = [ "media" ];

  services.jellyfin = {
    enable = true;
    dataDir = "/media/jellyfin-data";
    user = "jellyfin";
  };

  users.users."jellyfin".extraGroups = [
    "media"
    "video"
    "render"
  ];

  systemd.user.services.jellyfin-rpc = {
    enable = true;
    unitConfig.ConditionUser = "solarfire";
    after = [ "network.target" ];
    wantedBy = [ "default.target" ];
    description = "Start Jellyfin-RPC";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.jellyfin-rpc}/bin/jellyfin-rpc";
      ExecStartPre = "/usr/bin/env sleep 5";
    };
  };

  services.locate = {
    enable = true;
    package = pkgs.plocate;
  };

  services.caddy = {
    enable = true;
    virtualHosts."jellyfin.solarfire164.xyz" = {
      extraConfig = ''
        reverse_proxy :8096
      '';
      serverAliases = [ "solarfire164.xyz" ];
    };
    virtualHosts."sonarr.solarfire164.xyz".extraConfig = ''
      reverse_proxy :8989
    '';
    virtualHosts."radarr.solarfire164.xyz".extraConfig = ''
      reverse_proxy :7878
    '';
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  services.openssh.enable = true;
}
