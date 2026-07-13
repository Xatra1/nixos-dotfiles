{
  home-manager.users.solarfire.programs.plasma.configFile = {
    baloofilerc."Basic Settings".Indexing-Enabled = false;

    dolphinrc.DetailsMode = {
      ExpandableFolders = false;
      PreviewSize = 32;
    };

    kcminputrc."Libinput/1133/49291/Logitech G502 HERO Gaming Mouse".ScrollMethod = 4;

    kdeglobals = {
      KDE.DndBehavior = "MoveIfSameDevice";

      General = {
        TerminalApplication = "kitty";
        TerminalService = "kitty.desktop";
      };
    };

    ksmserverrc.General.loginMode = "emptySession";

    kwinrc = {
      Desktops = {
        Number = 2;
        Rows = 1;
      };

      Effect-blur = {
        BlurStrength = 7;
        NoiseStrength = 0;
      };

      Effect-magiclamp.AnimationDuration = 500;
      Effect-overview.BorderActivate = 9;

      Plugins = {
        blurEnabled = true;
        frozenappEnabled = false;
        magiclampEnabled = true;
        screenedgeEnabled = false;
        shakecursorEnabled = false;
        trackmouseEnabled = true;
        translucencyEnabled = true;
      };

      TabBox = {
        HighlightWindows = false;
        MultiScreenMode = 1;
        OrderMinimizedMode = 1;
      };

      Wayland.EnablePrimarySelection = false;
      Xwayland.XwaylandEisNoPromptApps = "xclicker";
    };
  };
}
