{ pkgs, ... }:
{
  services = {
    displayManager.plasma-login-manager.enable = true;
    desktopManager.plasma6.enable = true;
    flatpak.enable = true;
    lact.enable = true;
    tailscale.enable = true;
    openssh.enable = true;
    sonarr.enable = true;
    radarr.enable = true;

    udev.extraRules = ''
      ACTION=="add|change", KERNEL=="sd[a-z]*", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"
      ACTION=="add|change", KERNEL=="nvme[0-9]*", ENV{DEVTYPE}=="disk", ATTR{queue/scheduler}="bfq"
    '';

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    jellyfin = {
      enable = true;
      dataDir = "/media/jellyfin-data";
      user = "jellyfin";
    };

    locate = with pkgs; {
      enable = true;
      package = plocate;
    };

    caddy = {
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
  };

  security.rtkit.enable = true;

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

  users.users = {
    "sonarr".extraGroups = [ "media" ];
    "radarr".extraGroups = [ "media" ];

    "jellyfin".extraGroups = [
      "media"
      "video"
      "render"
    ];
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
