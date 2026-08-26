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

  ioquake3_overlay = (
    self: super: {
      ioquake3 = super.ioquake3.overrideAttrs (
        final: prev: {
          launchFlags = "";
        }
      );
    }
  );

  ironwail = pkgs.callPackage (pkgs.fetchurl {
    url = "https://codeberg.org/solarfire/nix-derivations/raw/branch/master/ironwail/package.nix";
    hash = "sha256-gq3rqsbeSlvK81hAc/0xOb9I38MIrNwcLyz1rmabMcs=";
  }) { };

  ironwail_overlay = (
    self: super: {
      ironwail = super.ironwail.overrideAttrs (
        final: prev: {
          launchFlags = "";
        }
      );
    }
  );

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

    overlays = [
      ventoy_overlay
      ioquake3_overlay
      ironwail_overlay
    ];
  };

  environment.systemPackages = with pkgs; [
    bat
    btop
    fastfetch
    firefox
    flatpak
    fontconfig
    git
    gparted
    hyfetch
    ioquake3
    ironwail
    kdePackages.filelight
    kdePackages.kate
    kdePackages.kcolorchooser
    kdePackages.markdownpart
    kdePackages.plasma-login-manager
    kitty
    mpv
    neovim
    nh
    nil
    nixfmt
    obs-studio
    protontricks
    protonup-qt
    satisfactorymodmanager
    spotify
    steam
    tailscale
    ventoy
    wget
    wine
    wl-clipboard
    xclicker
    zsh
  ];

  fonts = {
    fontconfig.enable = true;
    fontDir.enable = true;
    enableDefaultPackages = true;

    packages = [ miracode-nerd-font ];
  };

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
