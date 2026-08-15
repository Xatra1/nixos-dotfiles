{ pkgs, ... }:
let
  electronArgs = [
    "--ozone-platform=wayland"
    "--enable-smooth-scrolling"
    "--enable-blink-features=MiddleClickAutoscroll"
    "--enable-gpu-rasterization"
    "--enable-features=VaapiVideoDecodeLinuxGL"
  ];

  discord = pkgs.discord.override { commandLineArgs = electronArgs; };

  ironwail = pkgs.callPackage (pkgs.fetchurl {
    url = "https://codeberg.org/solarfire/nix-derivations/raw/branch/master/ironwail/package.nix";
    hash = "sha256-HrAVFCCB5EFIMzL74lt6Nk0P4Ddbk23LyLCYP0TmHOw=";
  }) { };

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

      permittedInsecurePackages = [
        "ventoy-1.1.17"
      ];
    };

    overlays = [ ventoy_overlay ];
  };

  environment.systemPackages = with pkgs; [
    bat
    btop
    discord
    fastfetch
    ffmpeg
    flatpak
    gcc
    git
    gparted
    hyfetch
    ibus
    ironwail
    jq
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
    nodejs-slim
    p7zip
    prettier
    protonup-qt
    rust-analyzer
    rustup
    steam
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

  security.polkit.enablePkexecWrapper = true; # needed for gparted to run

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
