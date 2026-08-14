This host has been discontinued and this branch remains only as an archive of the latest state of it's configuration.

# Structure
This only lists the differences between this branch and `master`.
```
nixos-dotfiles/                    
└─ modules/                        
   ├─ home-manager/                
   │  ├─ plasma/                   
   │  │  ├─ default.nix                 # removed startup.nix import
   │  │  ├─ extra-config-files.nix      # removed my desktop mouse scroll method, disabled blur and translucency and removed xclicker line
   │  │  ├─ panels.nix                  # removed second top panel and merged the system monitors into the first
   │  │  └─ startup.nix                 # removed
   │  ├─ btop.nix                     # removed second gpu line and excluded /home from IO output
   │  ├─ default.nix                  # removed easyeffects, equibop, and ssh imports
   │  ├─ easyeffects.nix              # no need for EQ on a laptop i never listen to audio on
   │  ├─ equibop.nix                  # laptop's cpu is too weak to handle vanilla discord, i'm not putting equibop on there
   │  ├─ git.nix                      # changed signing key
   │  └─ kitty.nix                    # disabled blur, reduced font size by 1pt
   ├─ configuration.nix             # added my main host as a subtituter 
   ├─ packages.nix                  # slightly modified electron flags and removed a ton of packages
   ├─ reused-strings.nix            # changed cpu and gpu names according to the laptop's hardware
   └─ services.nix                  # disabled basically every service lol
```
