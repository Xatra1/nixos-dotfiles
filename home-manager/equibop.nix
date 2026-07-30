{
  home-manager.users.solarfire = {
    programs.equibop = {
      enable = true;

      settings = {
        discordBranch = "stable";
        minimizeToTray = true;
        arRPC = true;
        splashColor = "rgb(239, 246, 247)";
        splashBackground = "rgb(28, 34, 42)";
        hardwareAcceleration = true;
        staticTitle = true;
        customTitleBar = true;
        badgesOnlyForMentions = true;
      };

      equicord.settings = {
        autoUpdate = true;
        autoUpdateNotification = false;

        plugins = {
          # vencord
          AlwaysTrust.enabled = true;
          BetterGifPicker.enabled = true;
          BetterUploadButton.enabled = true;

          CallTimer = {
            enabled = true;
            format = "human";
            trackSelf = true;
          };

          DisableCallIdle.enabled = true;
          DontRoundMyTimestamps.enabled = true;

          FakeNitro = {
            enabled = true;
            useStickerHyperLinks = false;
            useEmojiHyperLinks = false;
          };

          FavoriteGifSearch.enabled = true;
          FixCodeblockGap.enabled = true;
          FixImagesQuality.enabled = true;
          FixYoutubeEmbeds.enabled = true;
          ILoveSpam.enabled = true;
          MemberCount.enabled = true;
          MentionAvatars.enabled = true;
          MessageLatency.enabled = true;

          MessageLogger = {
            enabled = true;
            ignoreBots = true;
            ignoreSelf = true;
          };

          NoF1.enabled = true;
          PlatformIndicators.enabled = true;
          RelationshipNotifier.enabled = true;

          ShikiCodeblocks = {
            enabled = true;
            theme = "https://cdn.jsdelivr.net/gh/shikijs/textmate-grammars-themes@bc5436518111d87ea58eb56d97b3f9bec30e6b83/packages/tm-themes/themes/tokyo-night.json";
          };

          ShowMeYourName.enabled = true;
          TenorGifSearch.enabled = true;
          TypingTweaks.enabled = true;
          WhoReacted.enabled = true;
          YoutubeAdblock.enabled = true;

          # equicord
          BlockKrisp.enabled = true;

          Declutter = {
            enabled = true;
            removeAvatarDecoration = false;
            removeNameplate = false;
            removeProfileEffect = false;
            removeProfileFrame = false;
            removeClanTag = false;
            removeShopAboveDms = true;
            removeQuestsAboveDms = true;
            removeLibraryAboveDms = true;
            removeFamilyCenterAboveDms = true;
          };

          MessageColors.enabled = true;
          NoNitroUpsell.enabled = true;
          CancelFriendRequest.enabled = true;
          ShowSongName.enabled = true;
          UnitConverter.enabled = true;
        };
      };
    };
  };
}
