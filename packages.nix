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
    gamescope
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
    nixfmt
    noto-fonts
    nvd
    obs-studio
    p7zip
    pciutils
    prismlauncher
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
    stress
    tailscale
    typescript-language-server
    ventoy
    wget
    wine
    wl-clipboard
    x264
    xclicker
    xwininfo
    yt-dlp
    zsh
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    sddm
    khelpcenter
    kwalletmanager
    okular
    qrca
    drkonqi
    elisa
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-1.1.12"
  ];

  security.wrappers.btop = {
    source = "/run/current-system/sw/bin/btop";
    capabilities = "cap_perfmon+ep";
    owner = "root";
    group = "root";
  };

  systemd.tmpfiles.rules = [
    "Z /sys/class/powercap/intel-rapl:0/energy_uj 0444 root root - -"
  ];

  programs.dconf.enable = true;
  programs.gamescope.enable = true;
  programs.steam.enable = true;
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.nano.enable = false;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.zsh.enable = true;
  users.users.solarfire.shell = pkgs.zsh;
}
