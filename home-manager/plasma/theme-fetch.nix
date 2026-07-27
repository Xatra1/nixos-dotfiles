{ pkgs, ... }:
{
  home-manager.users.solarfire.xdg.dataFile = with pkgs; {
    "color-schemes/TokyoNight.colors".source = fetchurl {
      url = "https://raw.githubusercontent.com/Jayy-Dev/Plasma-Tokyo-Night/refs/heads/plasma-6/colorscheme/TokyoNight.colors";
      hash = "sha256-Qm6TY+5MCDIvvSkBn0iiLFL+ni4pMcokAJOtc2URelw=";
    };

    "plasma/desktoptheme/Amethyst/".source = fetchFromGitHub {
      owner = "ddh4r4m";
      repo = "Amethyst";
      rev = "a6af9b7727e0337b98a5705bc60b9a6b841761c7";
      hash = "sha256-Qzt6GIXZTh8NGEdUcL4wTnQmtmPiHn1/jJxYerLmPWc=";
      leaveDotGit = true; # forces it to clone the repo instead of pulling a zip archive

      postFetch = ''
        cd $out
        mv plasma/desktoptheme/Amethyst .
        rm -r color-schemes gtk konsole kvantum plasma plasmoids .git
        rm LICENSE README.md
      '';
    };

    "icons/Tela-circle-dark".source = (
      stdenv.mkDerivation (finalAttrs: {
        name = "tela-circle";
        version = "2026-07-07";

        src = fetchFromGitHub {
          owner = "vinceliuice";
          repo = "Tela-circle-icon-theme";
          rev = "${finalAttrs.version}";
          hash = "sha256-0P4KLwrBPsLMaSdaq06dUe8E1qFoGLlMbWxZ89GebKE=";
        };

        nativeBuildInputs = [ gtk3 ];

        dontConfigure = true;
        dontBuild = true;

        installPhase = ''
          mkdir $out

          patchShebangs .
          ./install.sh -d $out

          # fix broken symlinks by just replacing them with the files that were
          # being linked to in the first place
          cd $out

          # mv cannot overwrite symlinks with directories, so they need to be
          # removed first
          rm Tela-circle-dark/16/{apps,panel,status}
          rm Tela-circle-dark/22/{categories,emblems,panel}
          rm Tela-circle-dark/24/{animations,panel}
          mv Tela-circle/16/{apps,panel,status} Tela-circle-dark/16
          mv Tela-circle/22/{categories,emblems,panel} Tela-circle-dark/22
          mv Tela-circle/24/{animations,panel} Tela-circle-dark/24

          rm Tela-circle-dark/32 Tela-circle-dark/scalable
          rm Tela-circle-dark/32@2x Tela-circle-dark/scalable@2x
          mv Tela-circle/32 Tela-circle-dark
          ln -sf 32 32@2x
          mv Tela-circle/scalable Tela-circle-dark/scalable
          ln -sf scalable scalable@2x

          # these symlinks are just broken in general. im not sure what the
          # deal is
          rm Tela-circle-dark/symbolic/apps/xsi-addon-symbolic.svg
          rm Tela-circle-dark/scalable/apps/org.xfce.appfinder.svg

          mv Tela-circle-dark/* .

          # remove unused themes and the empty folder
          rm -r Tela-circle Tela-circle-{light,dark}
        '';
      })
    );

    "icons/Oxygen 08 Indigo".source = (
      stdenv.mkDerivation (finalAttrs: {
        name = "plasma-cursor-theme";
        version = "6.6.0";

        src = fetchurl {
          url = "https://download.kde.org/stable/plasma/${finalAttrs.version}/oxygen-${finalAttrs.version}.tar.xz";
          hash = "sha256-e797nKufLTJTgrd30b2BoVNAfHTfFhCiPpG0qgyvFaM=";
        };

        nativeBuildInputs = [
          xcursorgen
          inkscape
          cmake
        ];

        configurePhase = ''
          cd cursors/src
          sed -i '1s/^/project(oxygen)\n/' CMakeLists.txt
          sed -i '1s/^/cmake_minimum_required(VERSION 3.25)\n/' CMakeLists.txt

          cmake .
        '';

        themeName = "navy";
        enableParallelBuilding = true;
        buildFlags = [ "theme-${finalAttrs.themeName}" ];

        installPhase = ''
          mv oxy-${finalAttrs.themeName} $out

          echo "[Icon Theme]
          Name = Oxygen Indigo
          Comment = Oxygen mouse theme. Oxygenize your desktop!" > $out/index.theme

          rm -r $out/{config,cursors_scalable,png,svg}
        '';
      })
    );
  };
}
