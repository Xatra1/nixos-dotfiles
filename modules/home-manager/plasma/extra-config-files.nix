{
  programs.plasma.configFile = {
    baloofilerc."Basic Settings".Indexing-Enabled = false;
    kcminputrc."Libinput/1133/49291/Logitech G502 HERO Gaming Mouse".ScrollMethod = 4;
    ksmserverrc.General.loginMode = "emptySession";

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

    krunnerrc.Plugins = {
      baloosearchEnabled = false;
      browserhistoryEnabled = false;
      browsertabsEnabled = false;
      helprunnerEnabled = false;
      krunner_appstreamEnabled = false;
      krunner_bookmarksrunnerEnabled = false;
      krunner_charrunnerEnabled = false;
      krunner_dictionaryEnabled = false;
      krunner_katesessionsEnabled = false;
      krunner_keysEnabled = false;
      krunner_killEnabled = false;
      krunner_konsoleprofilesEnabled = false;
      krunner_kwinEnabled = false;
      krunner_placesrunnerEnabled = false;
      krunner_plasma-desktopEnabled = false;
      krunner_powerdevilEnabled = false;
      krunner_recentdocumentsEnabled = false;
      krunner_sessionsEnabled = false;
      krunner_shellEnabled = false;
      krunner_spellcheckEnabled = false;
      krunner_systemsettingsEnabled = false;
      krunner_webshortcutsEnabled = false;
      locationsEnabled = false;
      "org.kde.activities2Enabled" = false;
      "org.kde.datetimeEnabled" = false;
      unitconverterEnabled = false;
      windowsEnabled = false;
    };

    kwinrc = {
      Effect-overview.BorderActivate = 9;
      Wayland.EnablePrimarySelection = false;
      Xwayland.XwaylandEisNoPromptApps = "xclicker";

      Desktops = {
        Number = 2;
        Rows = 1;
      };

      Effect-blur = {
        BlurStrength = 7;
        NoiseStrength = 0;
      };

      Plugins = {
        blurEnabled = true;
        frozenappEnabled = false;
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
    };
  };
}
