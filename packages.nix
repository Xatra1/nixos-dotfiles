{ pkgs, ... }:
let
  electronArgs = [
    "--ozone-platform=wayland"
    "--enable-smooth-scrolling"
    "--enable-gpu-rasterization"
    "--enable-features=VaapiVideoDecodeLinuxGL"
  ];
in
{
  nixpkgs.config.allowUnfree = true;

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
    (callPackage ./nix-derivations/ventoy/package.nix { })
    vscode-langservers-extracted
    wget
    wine
    wl-clipboard
    zsh
  ];

  fonts.packages = with pkgs; [
    (callPackage ./nix-derivations/miracode.nix { })
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
