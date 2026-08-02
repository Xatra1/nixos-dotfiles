# Structure
This only lists the differences between this branch and `master`.
```
nixos-dotfiles/
├─ home-manager/
│  ├─ plasma/
│  │  ├─ default.nix                # removed startup.nix import
│  │  ├─ extra-config-files.nix     # removed my desktop mouse scroll method, disabled blur and translucency and removed xclicker line
│  │  ├─ panels.nix                 # removed second top panel and merged the system monitors into the first
│  │  └─ startup.nix                # removed entirely
│  ├─ btop.nix                    # removed second gpu line (duh, theres no dgpu) and excluded /home from IO output
│  ├─ default.nix                 # removed easyeffects line and never added equibop and ssh lines 
│  ├─ easyeffects.nix             # no need for EQ on a laptop i never listen to audio on
│  ├─ equibop.nix                 # laptop's cpu is too weak to handle vanilla discord, i'm not putting equibop on there
│  ├─ git.nix                     # changed signing key
│  └─ kitty.nix                   # disabled blur, reduced font size by 1pt
├─ packages.nix                 # slightly modified electron flags and removed a ton of packages
├─ plasma-overlay.nix           # no plans to add, this poor thing wouldn't be able to handle compiling it
├─ reused-strings.nix           # changed cpu and gpu names according to the laptop's hardware
└─ services.nix                 # disabled basically every service lol
```
