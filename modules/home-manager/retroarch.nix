{
  xdg.configFile."retroarch/config/SwanStation/SwanStation.opt".text = ''
    swanstation_BIOS_PathNTSCU = "openbios.bin"
    swanstation_CDROM_LoadImageToRAM = "true"
    swanstation_CDROM_SeekSpeedup = "0"
    swanstation_GPU_ResolutionScale = "5"
    swanstation_GPU_PGXPEnable = "true"
    swanstation_GPU_PGXPPreserveProjFP = "true"
  '';

  xdg.configFile."retroarch/config/remaps/mGBA/mGBA.rmp".text = ''
    input_player1_btn_a = "0"
    input_player1_btn_b = "8"
  '';

  xdg.configFile."retroarch/config/remaps/SwanStation/Castlevania - Symphony of the Night (USA).rmp".text =
    ''
      input_player1_btn_a = "9"
      input_player1_btn_x = "8"
    '';

  programs.retroarch = {
    enable = true;

    cores = {
      mgba.enable = true;
      swanstation.enable = true;
    };

    settings = {
      discord_allow = "true";
      gamemode_enable = "true";
      fastforward_ratio = "5.000000";
      input_rewind_btn = "11";
      input_toggle_fast_forward_btn = "12";
      menu_driver = "xmb";
      menu_swap_ok_cancel_buttons = "true";
      menu_xmb_animation_horizontal_highlight = "1";
      menu_xmb_animation_move_up_down = "1";
      menu_xmb_animation_opening_main_menu = "1";
      rewind_enable = "true";
      video_fullscreen = "true";
      video_refresh_rate = "240.000000";
      vrr_runloop_enable = "true";
      xmb_menu_color_theme = "21";
      xmb_switch_icons = "true";
      xmb_theme = "5";
    };
  };
}
