{ pkgs, ... }:
let
  ioquake3 = pkgs.callPackage (pkgs.fetchurl {
    url = "https://codeberg.org/solarfire/nix-derivations/raw/branch/master/ioquake3/package.nix";
    hash = "sha256-CAs+HIteMMYlZmCsoowzTdm3fv2PA/GfKgPFlxcHdcI=";
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
          launchFlags = "/home/solarfire/games/ironwail";
        }
      );
    }
  );

  miracode-nerd-font = pkgs.callPackage (pkgs.fetchurl {
    url = "https://codeberg.org/solarfire/nix-derivations/raw/branch/master/miracode/package.nix";
    hash = "sha256-WU+Vn9zP3zQpgJwPZEfwTazSDoB5Fp7HIqXtjmnfO4I=";
  }) { };

  btop = pkgs.btop.override {
    config.cudaSupport = true;
    config.rocmSupport = false; # needs to be explicitly disabled if cuda support is enabled?
  };
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ "ventoy-1.1.18" ];
    };

    overlays = [
      ioquake3_overlay
      ironwail_overlay
    ];
  };

  environment.systemPackages = with pkgs; [
    # keep-sorted start
    bat
    btop
    comma
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
    kdePackages.kruler
    kdePackages.markdownpart
    kdePackages.plasma-login-manager
    keep-sorted
    kitty
    mpv
    neovim
    nh
    nil
    nixfmt
    obs-studio
    prismlauncher
    protontricks
    protonup-qt
    satisfactorymodmanager
    steam
    tailscale
    ventoy
    wget
    wine
    wl-clipboard
    xclicker
    zsh
    # keep-sorted end
  ];

  fonts = {
    fontconfig.enable = true;
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = [ miracode-nerd-font ];
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    # keep-sorted start
    drkonqi
    elisa
    khelpcenter
    kwalletmanager
    okular
    qrca
    sddm
    # keep-sorted end
  ];

  security.polkit.enablePkexecWrapper = true; # needed for gparted to run

  systemd.tmpfiles.rules = [
    "Z /sys/class/powercap/intel-rapl:0/energy_uj 0444 root root - -"
  ];

  programs = {
    nano.enable = false;
    dconf.enable = true;
    zsh.enable = true;
    steam.enable = true;
    kde-pim.enable = false;

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
