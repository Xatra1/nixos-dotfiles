# Environment variables to force insubordinate programs into following the XDG
# Base Directory specification
{
  home.sessionVariables = {
    XDG_CACHE_HOME = "/home/solarfire/.cache";
    XDG_CONFIG_HOME = "/home/solarfire/.config";
    XDG_STATE_HOME = "/home/solarfire/.local/state";
    XDG_DATA_HOME = "/home/solarfire/.local/share";

    CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv";

    GTK2_RC_FILES = "$XDG_CONFIG_HOME/gtk-2.0/gtkrc";
    WGETRC = "$XDG_CONFIG_HOME/wgetrc";

    HISTFILE = "$XDG_STATE_HOME/bash_history";

    ANDROID_USER_HOME = "$XDG_DATA_HOME/android";
    GNUPGHOME = "$XDG_DATA_HOME/gnupg";
    RUSTUP_HOME = "$XDG_DATA_HOME/rustup";
    CARGO_HOME = "$XDG_DATA_HOME/cargo";
    WINEPREFIX = "$XDG_DATA_HOME/wine";
  };
}
