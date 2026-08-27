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
    hash = "sha256-nDr5NZH8JLKJonYbcqOG4wO/m3PE4qyeFw2o36H48DQ=";
  }) { };

  ironwail = pkgs.callPackage (pkgs.fetchurl {
    url = "https://codeberg.org/solarfire/nix-derivations/raw/branch/master/ironwail/package.nix";
    hash = "sha256-gq3rqsbeSlvK81hAc/0xOb9I38MIrNwcLyz1rmabMcs=";
  }) { };

  kate-discord-rpc = pkgs.callPackage (pkgs.fetchurl {
    url = "https://codeberg.org/solarfire/nix-derivations/raw/branch/master/kate-discord-rpc/package.nix";
    hash = "sha256-s/MgR88UxgmXZ7hieE9/ofYcKR04Ew/1QTXSdviCBgw=";
  }) { };

  miracode-nerd-font = pkgs.callPackage (pkgs.fetchurl {
    url = "https://codeberg.org/solarfire/nix-derivations/raw/branch/master/miracode/package.nix";
    hash = "sha256-WU+Vn9zP3zQpgJwPZEfwTazSDoB5Fp7HIqXtjmnfO4I=";
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

  equibop = pkgs.symlinkJoin {
    name = "equibop";
    paths = [ pkgs.equibop ];
    buildInputs = [ pkgs.makeWrapper ];

    postBuild = ''
      wrapProgram $out/bin/equibop \
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
    ffmpeg_8-full
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
    openrgb-with-all-plugins
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
