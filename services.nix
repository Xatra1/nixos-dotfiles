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
  };

  # Nix does not let you use integers on the left side of a binding without
  # turning them into strings, so declaratively configuring a GPU fan curve
  # using services.lact.settings is impossible in my case.
  environment.etc."lact/config.yaml".text = ''
    version: 6

    daemon:
      log_level: info
      admin_group: wheel
      disable_clocks_cleanup: false

    gpus:
      # NVIDIA GeForce RTX 3050
      10DE:2584-1458:4169-0000:02:00.0:
        fan_control_enabled: true

        fan_control_settings:
          mode: curve
          static_speed: 0.5
          temperature_key: edge
          interval_ms: 500
          curve:
            40: 0.75
            50: 0.8
            60: 0.9
            70: 1.0
            80: 1.0
          spindown_delay_ms: 5000
          change_threshold: 2
  '';

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
