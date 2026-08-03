{
  programs.plasma.configFile = {
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
