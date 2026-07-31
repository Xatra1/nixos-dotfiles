# Hosts
`lemon` - Main desktop. Also used as a "server" for file hosting and Jellyfin.  

- CPU: Intel Core i7-11700
- GPUs: Integrated UHD 750 + NVIDIA GeForce RTX 3050
- RAM: 32GB DDR4-2666
- Storage: 1TB NVME + 4TB HDD
  
`clementine` - Terrible laptop I got from school in my junior year. It's config is documented on the [clementine branch.](https://codeberg.org/solarfire/nixos-dotfiles/src/branch/clementine)  

- CPU: Intel Core i3-6100U
- GPU: Integrated HD 520
- RAM: 8GB DDR3L-1600
- Storage: 128GB SSD

# Structure
```
nixos-dotfiles/                     # root
|-- home-manager/                     # contains home-manager and plasma-manager modules
|   |-- plasma/                         # plasma-manager modules
|   |   |-- default.nix                 # imports plasma-manager modules, enables the config and contains configs too short to be their own files
|   |   |-- extra-config-files.nix      # anything in my config that couldn't be handled by a high-level module gets modified directly
|   |   |-- kate.nix                    # configuration for the text editor Kate
|   |   |-- panels.nix                  # a unique top panel for both my primary and secondary displays and a bottom panel containg pinned icons
|   |   |-- startup.nix                 # .desktop files to run when logging in
|   |   |-- theme-fetch.nix             # declaratively sources the plasma themes i use
|   |   |-- workspace.nix               # disables middle click paste (ew) + theme settings
|   |-- btop.nix                      # btop config
|   |-- default.nix                   # enables home-manager + some boilerplate stuff
|   |-- easyeffects.nix               # equalizer config because my headphones have negative bass
|   |-- equibop.nix                   # (mostly) plugin settings for equibop 
|   |-- fastfetch.nix                 # fastfetch because im unemployed
|   |-- git.nix                       # git config
|   |-- hyfetch.nix                   # hyfetch because im gay
|   |-- kitty.nix                     # kitty is the best terminal Ever
|   |-- mpv.nix                       # i barely use mpv idk why i made it's config declarative
|   |-- ssh.nix                       # ssh identity configs
|   |-- zsh.nix                       # very extensive zsh config that pulls in some plugins and my custom theme
|-- nix-derivations/                  # Submodule including custom-written nixpkgs
|-- configuration.nix               # generic system config and nix settings. anything i (arbitrarily) deemed irrelevant to the other root files
|-- hardware.nix                    # mountpoint, graphics drivers, and udev rules
|-- packages.nix                    # list of installed packages + some settings to get them to work properly
|-- plasma-overlay.nix              # overlay to fix plasma's performance regression on NixOS
|-- reused-strings.nix              # any generic string that gets used more than once throughout my config is probably defined here
|-- services.nix                    # systemd services and their related configs
```

# Won't Declaratively Configure
- OBS Studio - config too big
- jellyfin-rpc - contains my jellyfin API key
- iSponsorBlockTV - contains screen IDs used for casting to youtube. idk if those are private data or not and i don't care to find out
