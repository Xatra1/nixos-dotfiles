{ pkgs, ... }:
{
  xdg.dataFile = with pkgs; {
    "color-schemes/Amethyst.colors".source = fetchurl {
      url = "https://raw.githubusercontent.com/ddh4r4m/Amethyst/refs/heads/main/color-schemes/Amethyst.colors";
      hash = "sha256-Uu9K9LZ+/175QJSheYChdVExjZ5gV2IdGesOjhinnzs=";
    };

    "plasma/desktoptheme/Amethyst/".source = fetchFromGitHub {
      owner = "ddh4r4m";
      repo = "Amethyst";
      rev = "a6af9b7727e0337b98a5705bc60b9a6b841761c7";
      hash = "sha256-hzsA2ffhX+7DO/AiChbkgiccXTZS/xk1VQ79mKyG/yo=";
      leaveDotGit = true; # forces it to clone the repo instead of pulling a zip archive

      postFetch = ''
        cd $out
        mv plasma/desktoptheme/Amethyst/* .
        rm -r color-schemes gtk konsole kvantum plasma plasmoids .git
        rm LICENSE README.md
      '';
    };

    "icons/Tela-circle-dark".source = (
      stdenv.mkDerivation (finalAttrs: {
        name = "tela-circle";
        version = "0-unstable-2026-08-16";

        src = fetchFromGitHub {
          owner = "vinceliuice";
          repo = "Tela-circle-icon-theme";
          rev = "ee3cf47bcb05c3d99a0860b54254d2ff3d1d2c69";
          hash = "sha256-kvAJH/ptMvSCjk5Equi+8ZzHjSDKQUURUImNDZZXQcs=";
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

          rm Tela-circle-dark/{32,scalable}
          rm Tela-circle-dark/{32,scalable}@2x

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

    "icons/Oxygen 20 Peach Fruit".source = (
      stdenv.mkDerivation (finalAttrs: {
        themeName = "peach";
        name = "oxygen-cursor-${finalAttrs.themeName}";
        version = "6.8.0";

        src = fetchurl {
          url = "https://download.kde.org/stable/plasma/${finalAttrs.version}/oxygen-${finalAttrs.version}.tar.xz";
          hash = "sha256-43MCpyGc+t/bRir1mSrrB/0wrjlqXMbpqPGg4K4mgTY=";
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
        enableParallelBuilding = true;
        buildFlags = [ "theme-${finalAttrs.themeName}" ];

        installPhase = ''
          mv oxy-${finalAttrs.themeName} $out

          echo "[Icon Theme]
          Name = Oxygen Peach Fruit
          Comment = Oxygen mouse theme. Oxygenize your desktop!" > $out/index.theme

          rm -r $out/{config,cursors_scalable,png,svg}
        '';
      })
    );
  };
}
