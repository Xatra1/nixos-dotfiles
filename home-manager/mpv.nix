{
  home-manager.users.solarfire.programs.mpv = {
    enable = true;

    config = {
      demuxer-max-bytes = "700000KiB";
      fs = "yes";
      use-filedir-conf = "yes";
      audio-display = "no";
      osd-font = "Miracode Nerd Font";
    };

    profiles = {
      "audio-files" = {
        profile-cond = "(filename:match\"%.mp3$\" or filename:match\"%.opus$\" or filename:match\"%.flac$\" or filename:match\"%.wav$\" or filename:match\"cdda://\")";
        script-opts = "osc-visibility=always";
      };
    };

    # why the FUCK are these flipped by default
    bindings = {
      PGUP = "add chapter -1";
      PGDWN = "add chapter 1";
    };
  };
}
