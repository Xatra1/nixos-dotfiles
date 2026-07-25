{
  home-manager.users.solarfire.programs.plasma.configFile = {
    baloofilerc."Basic Settings".Indexing-Enabled = false;

    dolphinrc.DetailsMode = {
      ExpandableFolders = false;
      PreviewSize = 32;
    };

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

      Effect-overview.BorderActivate = 9;

      Plugins = {
        blurEnabled = false;
        frozenappEnabled = false;
        screenedgeEnabled = false;
        shakecursorEnabled = false;
        trackmouseEnabled = true;
      };

      TabBox = {
        HighlightWindows = false;
        MultiScreenMode = 1;
        OrderMinimizedMode = 1;
      };

      Wayland.EnablePrimarySelection = false;
    };
  };
}
