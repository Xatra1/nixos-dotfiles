{ pkgs, ... }:
{
  services = {
    displayManager.plasma-login-manager.enable = true;
    desktopManager.plasma6.enable = true;
    flatpak.enable = true;
    tailscale.enable = true;
    openssh.enable = true;
    sonarr.enable = true;
    radarr.enable = true;
    xserver.videoDrivers = [ "nvidia" ];

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

      virtualHosts."solarfire164.xyz".extraConfig = ''
        file_server browse
        root /var/www/data
      '';

      virtualHosts."jellyfin.solarfire164.xyz".extraConfig = ''
        reverse_proxy :8096
      '';

      virtualHosts."sonarr.solarfire164.xyz".extraConfig = ''
        reverse_proxy :8989
      '';

      virtualHosts."radarr.solarfire164.xyz".extraConfig = ''
        reverse_proxy :7878
      '';
    };

    nix-serve = {
      enable = true;
      port = 8080;
      secretKeyFile = "/home/solarfire/.local/share/nix-keys/secret";
    };

    hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
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

  users.groups.media.members = [
    "jellyfin"
    "sonarr"
    "radarr"
    "solarfire"
  ];

  users.users = {
    "jellyfin".extraGroups = [
      "video"
      "render"
    ];
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
    8080
  ];

  networking.firewall.allowedUDPPorts = [
    26000
  ];

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  virtualisation.oci-containers = {
    backend = "docker";

    containers."iSponsorBlockTV" = {
      image = "ghcr.io/dmunozv04/isponsorblocktv";

      volumes = [
        "/home/solarfire/Documents/Docker/iSponsorBlockTV:/app/data"
      ];

      extraOptions = [
        "--network=host"
      ];
    };
  };
}
