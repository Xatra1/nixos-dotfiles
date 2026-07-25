{ pkgs, ... }:
let
  electronArgs = [
    "--enable-smooth-scrolling"
    "--enable-blink-features=MiddleClickAutoscroll"
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
    caddy

    (discord.override {
      commandLineArgs = electronArgs;
    })

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
    (callPackage ./nix-derivations/ioquake3.nix { })
    (callPackage ./nix-derivations/ironwail.nix { })
    jellyfin
    jellyfin-rpc
    jellyfin-web
    jq
    (callPackage ./nix-derivations/kate-discord-rpc.nix { })
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
    protonup-qt
    qbittorrent
    radarr
    rust-analyzer
    rustup
    satisfactorymodmanager
    sof-firmware
    sonarr

    (pkgs.symlinkJoin {
      name = "spotify";
      paths = [ spotify ];
      buildInputs = [ makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/spotify \
          --add-flags "${lib.concatStringsSep " " electronArgs}"
      '';
    })

    steam
    tailscale
    typescript-language-server
    (callPackage ./nix-derivations/ventoy/package.nix { })
    vscode-langservers-extracted
    wget
    wine
    wl-clipboard
    x264
    xclicker
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
