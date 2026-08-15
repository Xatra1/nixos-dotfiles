{
  pkgs,
  lib,
  ...
}:
let
  electronArgs = [
    "--enable-smooth-scrolling"
    "--enable-blink-features=MiddleClickAutoscroll"
    "--enable-gpu-rasterization"
    "--enable-features=VaapiVideoDecodeLinuxGL"
  ];

  ioquake3 = pkgs.callPackage (pkgs.fetchurl {
    url = "https://codeberg.org/solarfire/nix-derivations/raw/branch/master/ioquake3/package.nix";
    hash = "sha256-c41yepb5CDUQOOJYgMIubUdpcjsiGypBHDe6N2QvvGk=";
  }) { };

  ironwail = pkgs.callPackage (pkgs.fetchurl {
    url = "https://codeberg.org/solarfire/nix-derivations/raw/branch/master/ironwail/package.nix";
    hash = "sha256-HrAVFCCB5EFIMzL74lt6Nk0P4Ddbk23LyLCYP0TmHOw=";
  }) { };

  kate-discord-rpc = pkgs.callPackage (pkgs.fetchurl {
    url = "https://codeberg.org/solarfire/nix-derivations/raw/branch/master/kate-discord-rpc/package.nix";
    hash = "sha256-tgg3tVrLMZq/SFKwvqASXC52RFv6InYIzFrhNO6t2o8=";
  }) { };

  miracode-nerd-font = pkgs.callPackage (pkgs.fetchurl {
    url = "https://codeberg.org/solarfire/nix-derivations/raw/branch/master/miracode/package.nix";
    hash = "sha256-IrNPFv0w/kgxwrx1fWM+3UxBCWzFEGgGq8SIiuBtX1U=";
  }) { };

  steelseriesgg-rs = pkgs.callPackage (pkgs.fetchurl {
    url = "https://codeberg.org/solarfire/nix-derivations/raw/branch/master/steelseriesgg-rs/package.nix";
    hash = "sha256-Io9OWJm5GOor9UjiXe4dSX+lTaW7TnVHnO5Wqnc2Njg=";
  }) { };

  spotify = pkgs.symlinkJoin {
    name = "spotify";
    paths = [ pkgs.spotify ];
    buildInputs = [ pkgs.makeWrapper ];

    postBuild = ''
      wrapProgram $out/bin/spotify \
        --add-flags "${lib.concatStringsSep " " electronArgs}"
    '';
  };

  ventoy_overlay = (
    self: super: {
      ventoy = super.ventoy.overrideAttrs (
        final: prev: {
          version = "1.1.17";

          src = pkgs.fetchurl {
            url = "https://github.com/ventoy/Ventoy/releases/download/v${final.version}/ventoy-${final.version}-linux.tar.gz";
            hash = "sha256-f7TtCM72prTTndGSYNjIApGnjf35r31GFXHiPLvEOAU=";
          };

          patches = [
            (pkgs.fetchurl {
              url = "https://codeberg.org/solarfire/nix-derivations/raw/branch/master/ventoy/000-nixos-sanitization.patch";
              hash = "sha256-Wn37erHT0TuaPswObiXk8vCJ4UUG+aS5OIYqcRBuPNQ=";
            })
          ];
        }
      );
    }
  );

  btop = pkgs.btop.override {
    config.cudaSupport = true;
    config.rocmSupport = false; # needs to be explicitly disabled if cuda support is enabled?
  };
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;

      permittedInsecurePackages = [
        "ventoy-1.1.17"
      ];
    };

    overlays = [ ventoy_overlay ];
  };

  environment.systemPackages = with pkgs; [
    android-tools
    bat
    btop
    caddy
    docker
    easyeffects
    equibop
    fastfetch
    ffmpeg-full
    flatpak
    gcc
    gimp
    git
    gparted
    headsetcontrol
    hyfetch
    ibus
    ioquake3
    ironwail
    jellyfin
    jellyfin-rpc
    jellyfin-web
    jq
    kate-discord-rpc
    kdePackages.filelight
    kdePackages.kate
    kdePackages.kcolorchooser
    kdePackages.markdownpart
    kdePackages.plasma-login-manager
    kitty
    lact
    marksman
    mediainfo
    mkvtoolnix
    mpv
    neovim
    nh
    nil
    nix-serve
    nixfmt
    nodejs-slim
    obs-studio
    p7zip
    prettier
    protontricks
    protonup-qt
    qbittorrent
    radarr
    rust-analyzer
    rustup
    satisfactorymodmanager
    sof-firmware
    sonarr
    spotify
    steam
    steelseriesgg-rs
    tailscale
    typescript-language-server
    ventoy
    vscode-langservers-extracted
    wget
    wine
    wl-clipboard
    x264
    xclicker
    zsh
  ];

  fonts.packages = with pkgs; [
    miracode-nerd-font
    noto-fonts
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    sddm
    khelpcenter
    kwalletmanager
    okular
    qrca
    drkonqi
    elisa
    kwin-x11
  ];

  security = {
    polkit.enablePkexecWrapper = true; # needed for gparted to run

    wrappers.btop = {
      source = "/run/current-system/sw/bin/btop";
      capabilities = "cap_perfmon+ep";
      owner = "root";
      group = "root";
    };
  };

  systemd.tmpfiles.rules = [
    "Z /sys/class/powercap/intel-rapl:0/energy_uj 0444 root root - -"
  ];

  # unsure how to import the steelseriesgg-rs binding into services.nix, so
  # this will have to remain here.
  systemd.user.services.ssgg = {
    enable = true;
    unitConfig.ConditionUser = "solarfire";
    wantedBy = [ "default.target" ];
    description = "SteelSeries GG Linux Daemon";

    serviceConfig = {
      Type = "simple";
      ExecStart = "${steelseriesgg-rs}/bin/ssgg daemon";
    };
  };

  programs = {
    nano.enable = false;
    dconf.enable = true;
    zsh.enable = true;
    steam.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    nh = {
      enable = true;

      clean = {
        enable = true;
        dates = "daily";
      };
    };
  };
}
