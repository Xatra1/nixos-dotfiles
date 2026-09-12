{ pkgs, ... }:
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
      fastforward_ratio = "5.000000";
      gamemode_enable = "true";
      input_rewind_btn = "11";
      input_toggle_fast_forward_btn = "12";
      menu_driver = "xmb";
      menu_swap_ok_cancel_buttons = "true";
      menu_xmb_animation_horizontal_highlight = "1";
      menu_xmb_animation_move_up_down = "1";
      menu_xmb_animation_opening_main_menu = "1";
      rewind_enable = "true";
      rgui_browser_directory = "~/.local/share/Games"; # i'm not sure why the option specifies rgui, this applies to all menu drivers
      show_hidden_files = "true";
      video_fullscreen = "true";
      video_refresh_rate = "240.000000";
      vrr_runloop_enable = "true";
      xmb_menu_color_theme = "21";
      xmb_switch_icons = "true";
      xmb_theme = "5";

      # automatically updates paths to follow changes to the Nix store
      assets_directory = "${pkgs.retroarch-assets}/share/retroarch/assets";
      joypad_autoconfig_dir = "${pkgs.retroarch-joypad-autoconfig}/share/libretro/autoconfig";
      libretro_directory = "${pkgs.retroarch}/lib/retroarch/cores";
      libretro_info_path = "${pkgs.libretro-core-info}/share/retroarch/cores";
    };
  };
}
