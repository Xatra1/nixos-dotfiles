# Hosts
| Name         | Description                                                          | CPU                 | GPU                                          | RAM            | Storage              |
|--------------|----------------------------------------------------------------------|---------------------|----------------------------------------------|----------------|----------------------|
| `lemon`      | Main desktop. Also used as a "server" for file hosting and Jellyfin. | Intel Core i7-11700 | Integrated UHD 750 + NVIDIA GeForce RTX 3050 | 32GB DDR4-2666 | 500GB NVMe + 4TB HDD |
| `clementine` | Terrible laptop I got from school in my junior year.                 | Intel Core i3-6100U | Integrated HD 520                            | 8GB DDR3L-1600 | 128GB SSD            |


## Adding a host
**Replace any instance of "hostname" below with the hostname of the device.**  

**1, Modify the "hostname" binding in the flake:**
```nix
# flake.nix
let
  hostname = "lemon"; # your hostname here
in
```

**2. Generate unique SSH and GPG key pairs for the new host:**
- SSH:
```sh
ssh-keygen
wl-copy -t text/plain < ~/.ssh/id_ed25519.pub
# create a new ssh key entry on codeberg and paste the result into the Content field

# click Verify on the newly added key
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_ed25519
# codeberg will give you commands to run that generate a signature. copy the second one, run it, and paste the resulting output into the
# "Armored SSH signature" field
```

- GPG:
```sh
gpg --full-generate-key # key should be a 4096 rsa key
gpg --list-secret-keys --keyid-format=long | head -n 4 | tail -n 1
# copy the key id
gpg --armor --export KEYID
# create a new gpg key entry on codeberg and paste the result into the Content field
# you will need to add the key to github as well

# click Verify on the newly added key
# codeberg will give you a command to run that generates a signature. run it, and paste the resulting output into the "Armored GPG signature" 
# field
```

**3. Spawn a shell with git:**
```sh
nix-shell -p git
```

**4. Clone the repository:**
```sh
git clone --recursive git@codeberg.org:solarfire/nixos-dotfiles
# you can also use the following mirror if codeberg happens to be down:
git clone --recursive git@github.com:Xatra1/nixos-dotfiles
```

**5. Create an orphan branch based off the latest master commit:**
```sh
git checkout --orphan hostname
```

**6. Make any necessary changes. All differences between the main branch and the new host should be documented in a structure like below.**  
*See the [clementine branch README](https://codeberg.org/solarfire/nixos-dotfiles/src/branch/clementine/README.md) for an example.*  

**Note**: Before you can commit, you will need to change `settings.signing.key` in `home-manager/git.nix` to the host's new GPG key ID, which you can find using this command:
```sh
gpg --list-secret-keys --keyid-format=long | head -n 4 | tail -n 1
```

**7. Test the changes:**
```sh
sudo nixos-rebuild test
# once you're happy with the results, run with the "switch" flag instead:
sudo nixos-rebuild switch
```

**8. Commit them:**
```sh
git commit -m "init hostname branch" -a
```

**9. Push the new branch to the remote:**
```sh
git push
```

**Note**: Setting up a remote url is not necessary as long as `settings.push.autoSetupRemote` is set to `true` in `home-manager/git.nix` is used. Otherwise:
```sh
git push --set-upstream origin branch-name
```

# Structure
```
nixos-dotfiles/                       # root
├─ modules/                             # nix modules
│   ├─ home-manager/                      # home-manager and plasma-manager modules
│   │  ├─ plasma/                           # plasma-manager modules
│   │  │  ├─ default.nix                    # imports plasma-manager modules, enables the config and contains configs too short to be separated
│   │  │  ├─ extra-config-files.nix         # anything in my config that couldn't be handled by a high-level module gets modified directly
│   │  │  ├─ kate.nix                       # configuration for the text editor Kate
│   │  │  ├─ panels.nix                     # a unique top panel for both of my displays and a bottom panel containg pinned icons
│   │  │  ├─ startup.nix                    # .desktop files to run when logging in
│   │  │  ├─ theme-fetch.nix                # declaratively sources the plasma themes i use
│   │  │  └─ workspace.nix                  # disables middle click paste (ew) + theme settings
│   │  ├─ btop.nix                        # btop config
│   │  ├─ default.nix                     # enables home-manager + some boilerplate stuff
│   │  ├─ easyeffects.nix                 # equalizer config because my headphones have negative bass
│   │  ├─ equibop.nix                     # (mostly) plugin settings for equibop
│   │  ├─ fastfetch.nix                   # fastfetch because im unemployed
│   │  ├─ git.nix                         # git config
│   │  ├─ hyfetch.nix                     # hyfetch because im gay
│   │  ├─ kitty.nix                       # kitty is the best terminal Ever
│   │  ├─ mpv.nix                         # i barely use mpv idk why i made its config declarative
│   │  ├─ ssh.nix                         # ssh identity configs
│   │  └─ zsh.nix                         # very extensive zsh config that pulls in some plugins and my custom theme
│   ├─ configuration.nix                # generic system config and nix settings. anything i (arbitrarily) deemed irrelevant to other root files
│   ├─ hardware.nix                     # mountpoints, graphics drivers, and udev rules
│   ├─ packages.nix                     # list of installed packages + some settings to get them to work properly
│   ├─ plasma-overlay.nix               # overlay to fix plasma's performance regression on NixOS
│   ├─ reused-strings.nix               # any generic string that gets used more than once throughout my config is probably defined here
│   └─ services.nix                     # systemd services and their related configs
├─ flake.lock                         # input version pinning
└─ flake.nix                          # contains nixpkgs, home-manager, and plasma-manager inputs
```

# Won't Declaratively Configure
- OBS Studio - config too big
- jellyfin-rpc - contains my jellyfin API key
- iSponsorBlockTV - contains screen IDs used for casting to youtube. idk if those are private data or not and i don't care to find out
