{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    bat
    btop
    caddy
    chromium
    discord
    docker
    easyeffects
    fastfetch
    ffmpeg
    flatpak
    gcc
    gimp
    git
    gparted
    headsetcontrol
    hyfetch
    ioquake3
    ironwail
    jellyfin
    jellyfin-rpc
    jellyfin-web
    jq
    (callPackage ./derivations/kate-discord-rpc.nix { })
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
    nil
    nixfmt
    nodejs-slim
    nvd
    obs-studio
    p7zip
    prettier
    protontricks
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
    (callPackage ./derivations/miracode.nix { })
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

  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-1.1.12"
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
  };
}
