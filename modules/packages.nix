{ pkgs, ... }:
let
  electronArgs = [
    "--ozone-platform=wayland"
    "--enable-smooth-scrolling"
    "--enable-gpu-rasterization"
    "--enable-features=VaapiVideoDecodeLinuxGL"
  ];

  miracode-nerd-font = pkgs.callPackage (pkgs.fetchurl {
    url = "https://codeberg.org/solarfire/nix-derivations/raw/branch/master/miracode/package.nix";
    hash = "sha256-IrNPFv0w/kgxwrx1fWM+3UxBCWzFEGgGq8SIiuBtX1U=";
  }) { };

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
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ "ventoy-1.1.17" ];
    };

    overlays = [ ventoy_overlay ];
  };

  environment.systemPackages = with pkgs; [
    android-tools
    bat
    btop

    (discord.override {
      commandLineArgs = electronArgs;
    })

    fastfetch
    flatpak
    gcc
    git
    gparted
    home-manager
    hyfetch
    jq
    kdePackages.filelight
    kdePackages.kate
    kdePackages.kcolorchooser
    kdePackages.markdownpart
    kdePackages.plasma-login-manager
    kitty
    marksman
    mpv
    neovim
    nil
    nixfmt
    nodejs-slim
    nvd
    p7zip
    prettier
    rust-analyzer
    rustup
    tailscale
    typescript-language-server
    ventoy
    vscode-langservers-extracted
    wget
    wine
    wl-clipboard
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

    neovim = {
      enable = true;
      defaultEditor = true;
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
